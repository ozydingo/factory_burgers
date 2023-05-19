require "json"

module FactoryBurgers
  module Middleware
    # Respond with factory data to display in the main form
    class Data
      def call(*)
        factories = FactoryBurgers::Introspection.factories
        models = factories.map { |factory| factory_model(factory) }.select(&:valid?)
        factory_data = models.map(&:to_h)
        return [200, {"Content-Type" => "application/json"}, [JSON.dump(factory_data)]]
      end

      def factory_model(factory)
        FactoryBurgers::Models::Factory.new(factory)
      end
    end
  end
end
