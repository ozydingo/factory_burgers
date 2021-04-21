module FactoryBurgers
  module Introspection
    module_function

    def factories
      FactoryBot.factories.sort_by(&:name)
    end

    # Return a list of factories for a model instance's associations
    def association_factories(klass)
      associations = klass.reflect_on_all_associations.reject { |assoc| assoc.is_a?(ActiveRecord::Reflection::ThroughReflection) }
      factories = associations.flat_map do |assoc|
        factories_for_class(assoc.klass).map do |factory|
          {
            association: assoc,
            factory: factory,
          }
        end
      end
      return factories
    end

    def factories_for_class(klass)
      FactoryBot.factories.select do |factory|
        factory.build_class.ancestors.include?(klass)
      end
    end
  end
end
