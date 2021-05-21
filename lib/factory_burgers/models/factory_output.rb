module FactoryBurgers
  module Models
    class FactoryOutput
      attr_reader :object

      # `object` is whatever the output of `Factory#create` was
      def initialize(object)
        @object = object
      end

      def data
        # TODO: Sorting by name is a UI concern; move it there.
        sorted_assocs = association_factories.sort_by { |item| item[:association].name }
        return {
          type: object.class.name,
          attributes: object.attributes,
          association_factories: sorted_assocs.map { |item| association_factory_data(item) },
          link: FactoryBurgers::Observation.app_link(object),
        }
      end

      private

      def association_factories
        FactoryBurgers::Introspection.association_factories(object.class)
      end

      def association_factory_data(assoc_factory)
        {
          association_name: assoc_factory[:association].name.to_s,
          factory_name: assoc_factory[:factory].name.to_s,
        }
      end
    end
  end
end
