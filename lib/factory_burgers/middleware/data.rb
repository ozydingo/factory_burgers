require "json"

module FactoryBurgers
  module Middleware
    # Respond with factory data to display in the main form
    class Data
      def call(*)
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
