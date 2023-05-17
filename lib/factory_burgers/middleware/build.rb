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
        owner = get_resource_owner(params["owner_type"], params["owner_id"])
        return FactoryBurgers::Builder.new(owner).build(factory, traits, attributes, as: params["owner_association"])
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
        return attribute_items.to_h { |attr| [attr["name"], attr["value"]] }
      end

      def get_resource_owner(owner_type, owner_id)
        return nil if owner_type.blank? || owner_id.blank?

        klass = owner_type.constantize
        invalid_resource(klass) if !valid_resource?(klass)

        return klass.find(owner_id)
      end

      def log_error(error)
        logger.error("#{error.class}: #{error.message}\n" + error.backtrace&.join("\n").to_s)
      end

      def logger
        @logger ||= Logger.new($stdout)
      end

      private

      def valid_resource?(klass)
        klass < ActiveRecord::Base
      end

      def invalid_resource(klass)
        raise FactoryBurgers::Errors::InvalidRequestError, "#{klass.name} is not a valid resource."
      end
    end
  end
end
