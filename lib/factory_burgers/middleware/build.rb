require "logger"
require "json"

module FactoryBurgers
  module Middleware
    # Build a requested resource and return data for follow-up actions
    # TODO: extract controller methods into controller-like classes
    class Build
      def call(env)
        resource = build(env)
        object_data = FactoryBurgers::Models::FactoryOutput.new(resource).data
        response_data = {ok: true, data: object_data}
        return [200, {"Content-Type" => "application/json"}, [JSON.dump(response_data)]]
      rescue ActiveRecord::RecordInvalid => err
        log_error(err)
        return [422, {"Content-Type" => "application/json"}, [JSON.dump({ok: false, error: err.message})]]
      rescue StandardError => err
        log_error(err)
        return [500, {"Content-Type" => "application/json"}, [JSON.dump({ok: false, error: err.message})]]
      end

      def build(env)
        params = paramters(env)
        factory = params.fetch("factory")
        traits = params["traits"]&.keys
        attributes = attribute_overrides(params["attributes"])
        owner = get_resource_owner(params[:owner_type], params[:owner_id], params[:owner_association])
        return FactoryBurgers::Builder.new.build(factory, traits, attributes, owner)
      end

      def request(env)
        Rack::Request.new(env)
      end

      def paramters(env)
        request(env).params
      end

      def attribute_overrides(attribute_items)
        return [] if attribute_items.nil?

        attribute_items = attribute_items.select { |attr| attr["name"].present? }
        return attribute_items.map { |attr| [attr["name"], attr["value"]] }.to_h
      end

      # TODO: make params explicit
      def get_resource_owner(owner_type, owner_id, owner_association)
        return nil if owner_type.blank? || owner_id.blank? || owner_association.blank?

        klass = owner_type.constantize
        invalid_build_class(klass) if !valid_build_class?(klass)
        invalid_association(klass) if !valid_owner?(klass, owner_association)

        return klass.constantize.find(owner_id)
      end

      def log_error(error)
        logger.error("#{error.class}: #{error.message}\n" + error.backtrace&.join("\n").to_s)
      end

      def logger
        @logger ||= Logger.new($stdout)
      end

      private

      def valid_build_class?(klass)
        klass < ActiveRecord::Base
      end

      def invalid_build_class(klass)
        raise "#{klass.name} is not a thing I can build."
      end

      def valid_association?(klass, assoc_name)
        klass.reflections.include?(assoc_name)
      end

      def invalid_association(klass, association)
        raise "#{association} is not an association for #{klass.name}!"
      end
    end
  end
end
