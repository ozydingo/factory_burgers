# A SequenceInjector is a probe that can be used to hijcak a FactoryBot sequence.
# It injects a specific replacement value in place of the sequence argument, or
# any usage of that argument.
#
# For an injector with a replacement value "foo":
#
# * A sequence defined with a block ``{ |ii| "thing-#{ii} "}`
#    will evaluate to "thing-foo".
# * A sequence defined with a block ``{ |ii| "thing-#{ii.days.from_onw.month} "}`
#    will also evaluate to "thing-foo".
#
# This allows us to generate wildcard, such as for SQL
#   SequenceInjector.new("%")
# or Regex
#     SequenceInjector.new(".")

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
