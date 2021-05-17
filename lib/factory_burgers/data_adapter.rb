module FactoryBurgers
  module DataAdapter
    module_function

    ## TODO: these method move to a data class, Factory
    def factory_data(factory)
      traits = factory.definition.defined_traits
      {
        name: factory.name,
        class_name: factory.build_class.base_class.name,
        traits: traits.map { |trait| trait_data(trait) },
        attributes: factory.build_class.columns.reject { |col| col.name == "id" }.map { |col| attribute_data(col) },
        # TODO: transient attributes (f.definition.attributes ...?), associations
      }
    end

    def trait_data(trait)
      {
        name: trait.name,
      }
    end

    def attribute_data(attribute)
      {
        name: attribute.name,
      }
    end

    ## TODO: these methods move to a data class, ConsntructedResource
    def built_object_data(object)
      association_factories = FactoryBurgers::Introspection.association_factories(object.class)
      association_factories.sort_by! { |item| item[:association].name }
      return {
        type: object.class.name,
        attributes: object.attributes,
        association_factories: association_factories.map { |item| association_factory_data(item) },
        link: FactoryBurgers::Observation.app_link(object),
      }
    end

    def association_factory_data(assoc_factory)
      {
        association_name: assoc_factory[:association].name.to_s,
        factory_name: assoc_factory[:factory].name.to_s,
      }
    end
  end
end
