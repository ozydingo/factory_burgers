require "json"

module FactoryBurgers
  module Models
    # Represent a factory and associated data needed for UI
    # TODO: support transient attributes (f.definition.attributes ...?)
    # TODO: support associations
    class Factory
      attr_reader :factory

      def initialize(factory)
        @factory = factory
      end

      def valid?
        build_class.present?
      end

      def to_h
        {
          name: name,
          class_name: class_name,
          traits: traits.map(&:to_h),
          attributes: attributes.map(&:to_h),
        }
      end

      def to_json(...)
        to_h.to_json(...)
      end

      def name
        factory.name.to_s
      end

      def class_name
        build_class.base_class.name
      end

      def traits
        defined_traits.map { |trait| Trait.new(trait) }
      end

      def attributes
        settable_columns.map { |col| Attribute.new(col) }
      end

      private

      def build_class
        factory.build_class
      rescue NameError
        # Some usages of factories include pseudo "abstract" factory parent classes that do not point to a real class
        nil
      end

      def settable_columns
        factory.build_class.columns.reject { |col| col.name == build_class.primary_key }
      end

      def defined_traits
        factory.definition.defined_traits
      end
    end

    # :nodoc:
    class Attribute
      attr_reader :column

      def initialize(column)
        @column = column
      end

      def to_h
        {name: name}
      end

      def to_json(...)
        to_h.to_json(...)
      end

      def name
        column.name
      end
    end

    # :nodoc:
    class Trait
      attr_reader :trait

      def initialize(trait)
        @trait = trait
      end

      def to_h
        {name: name}
      end

      def to_json(...)
        to_h.to_json(...)
      end

      def name
        trait.name
      end
    end
  end
end
