module FactoryBurgers
  module Models
    class FactoryOutput
      attr_reader :object, :presenter

      # `object` is whatever the output of `Factory#create` was
      def initialize(object)
        @object = object
        @presenter = FactoryBurgers::Presenters.presenter_for(object)
      end

      def data
        # TODO: Sorting by name is a UI concern; move it there.
        sorted_assocs = association_factories.sort_by { |item| item[:association].name }
        # TODO: group type, attributes, and link into `object`, move keys into presenter
        return {
          type: presenter.type,
          attributes: presenter.attributes,
          link: presenter.link_path,
          association_factories: sorted_assocs.map { |item| association_factory_data(item) },
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
