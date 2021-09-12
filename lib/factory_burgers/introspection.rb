module FactoryBurgers
  # Discover information about factories for a class, such as what associations
  # are defined on that class that also have factories we can use
  module Introspection
    module_function

    def factories
      FactoryBurgers.factory_bot_adapter.factories.sort_by(&:name)
    end

    # Return a list of factories for a model instance's associations
    def association_factories(klass)
      buildable_associations(klass).flat_map do |assoc|
        factories_for_class(assoc.klass).map do |factory|
          {
            association: assoc,
            factory: factory,
          }
        end
      end
    end

    def factories_for_class(klass)
      factories.select do |factory|
        factory.build_class.ancestors.include?(klass)
      end
    end

    def buildable_associations(klass)
      klass.reflect_on_all_associations.reject { |assoc| assoc.is_a?(ActiveRecord::Reflection::ThroughReflection) }
    end
  end
end
