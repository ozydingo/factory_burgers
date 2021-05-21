require "json"

module FactoryBurgers
  module Middleware
    class Data
      def call(env)
        factories = FactoryBot.factories.sort_by(&:name)
        factory_data = factories.map { |factory| factory_data(factory) }
        return [200, {"Content-Type" => "application/json"}, [JSON.dump(factory_data)]]
      end

      def factory_data(factory)
        FactoryBurgers::Models::Factory.new(factory).to_h
      end
    end
  end
end
