module FactoryBurgers
  # A SequenceCheater is able to take the block associated with a factory's
  # attribute and discover if it uses a sequence (specifically, if it calls
  # `generate`). It does this by evaluting the block in its own context, where
  # the `generate` method has been defined to save the name it was called with.
  #
  # For example, in the following factory:
  #
  # FactoryBot.define do
  #   factory :foo do
  #     bar { generate :baz }
  #   end
  # end
  #
  # We can discover the `bar` attribute of the factory, and throgh some slightly
  # dangerous non-public access (it's Ruby, after all) we can get the block
  # defined as `{ generate :baz }`. We then call that block on a SequenceCheater,
  # which simply records that `generate` was called with the name `:baz`.
  class SequenceCheater < BasicObject
    attr_reader :sequence_names

    def initialize
      @sequence_names = []
    end

    def generate(name = nil, *_args, &_blk)
      @sequence_names |= [name] unless name.nil?
    end

    # We explicitly want to swallow and do nothing on method_missing;
    # We only want to detect occurences of `generate`.
    def method_missing(_name, *_args)
      # do nothing, do not fail
    end

    private

    # While a no-op, we define it for linters
    def respond_to_missing?(*_args)
      false
    end
  end
end
