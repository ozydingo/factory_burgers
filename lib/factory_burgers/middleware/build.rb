require "logger"
require "json"

module FactoryBurgers
  module Middleware
    # TODO: extract controller methods into controller-like classes
    class Build
      def call(env)
        params = paramters(env)
        factory = params.fetch("factory")
        traits = params["traits"]&.keys
        attributes = attribute_overrides(params)
        owner = get_resource_owner(params)
        resource = FactoryBurgers::Builder.new.build(factory, traits, attributes, owner)
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

      def request(env)
        Rack::Request.new(env)
      end

      def paramters(env)
        request(env).params
      end

      def attribute_overrides(params)
        attribute_items = params["attributes"] || []
        attribute_items = attribute_items.reject{ |attr| !attr["name"].present? }
        return attribute_items.map { |attr| [attr["name"], attr["value"]] }.to_h
      end

      # TODO: make params explicit
      def get_resource_owner(params)
        return nil if params[:owner_type].blank? || params[:owner_id].blank? || params[:owner_association].blank?

        valid_owner_types = ActiveRecord::Base.descendants.map(&:name)
        raise "Danger, will Robinson! #{params[:owner_type]} is an impostor!" if !valid_owner_types.include?(params[:owner_type])

        klass = params[:owner_type].constantize
        raise "Danger, will Robinson! #{params[:owner_association]} is an impostor!" if !klass.reflections.include?(params[:owner_association])

        return params[:owner_type].constantize.find(params[:owner_id])
      end

      def log_error(error)
        logger.error("#{error.class}: #{error.message}\n" + error.backtrace&.join("\n").to_s)
      end

      def logger
        @logger ||= Logger.new($stdout)
      end
    end
  end
end
