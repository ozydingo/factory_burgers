module FactoryBurgers
  module DataAdapter
    module_function

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
  end
end
