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

      def app_link
        {
          url: link_path,
          label: link_label
        }
      end

      def link_path
        link = FactoryBurgers::Observation.app_link(object)
        link && link[:url]
      end

      def link_label
        link = FactoryBurgers::Observation.app_link(object)
        link && link[:label]
      end
    end
  end
end
