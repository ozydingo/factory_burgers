module FactoryBurgers
  class SequenceInjector < BasicObject
    def initialize(replacement_value)
      @replacement_value = replacement_value
    end

    def to_s
      @replacement_value
    end

    # rubocop:disable Style/MethodMissingSuper
    # We explicitly want to swallow and do nothing on method_missing;
    # We want to chain all method calls until we get to to_s
    def method_missing(_name, *_args)
      return self
    end
    # rubocop:enable Style/MethodMissingSuper

    private

    def respond_to_missing?(_name, *_args)
      false
    end
  end
end
