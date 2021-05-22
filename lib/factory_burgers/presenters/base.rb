module FactoryBurgers
  module Presenters
    class Base
      class << self
        def presents(name)
          define_method(name) { object }
        end
      end

      attr_reader :object

      def initialize(object)
        @object = object
      end

      def type
        object.class.name
      end

      def attributes
        object.attributes.slice("id", "name")
      end

      def link_path
        nil
      end
    end
  end
end
