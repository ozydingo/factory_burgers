module FactoryBurgers
  class SequenceCheater < BasicObject
    attr_reader :sequence_names

    def initialize
      @sequence_names = []
    end

    def generate(name = nil, *_args, &_blk)
      @sequence_names |= [name] unless name.nil?
    end

    # rubocop:disable Style/MethodMissingSuper
    # We explicitly want to swallow and do nothing on method_missing;
    # We only want to detect occurences of `generate`.
    def method_missing(_name, *_args)
      # do nothing, do not fail
    end
    # rubocop:enable Style/MethodMissingSuper

    private

    # While a no-op, we define it for linters
    def respond_to_missing?(*_args)
      false
    end
  end
end
