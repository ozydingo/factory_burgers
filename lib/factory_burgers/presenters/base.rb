module FactoryBurgers
  module Presenters
    class Base
      attr_reader :object

      def initialize(object)
        @object = object
      end

      def type
        object.class.name
      end

      def attributes
        @object.attributes
      end

      def app_link
        FactoryBurgers::Observation.app_link(object)
      end
    end
  end
end
