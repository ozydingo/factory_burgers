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
        FactoryBurgers::DataAdapter.factory_data(factory)
      end
    end
  end
end
