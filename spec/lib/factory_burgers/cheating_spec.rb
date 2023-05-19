describe FactoryBurgers::Cheating do
  describe "discover_sequences" do
    it "detects one sequence attribute defined" do
      factory = FactoryBurgers.factory_bot_adapter.factories.find(:factory_with_one_sequence)
      sequences = FactoryBurgers::Cheating.discover_sequences(factory)
      expect(sequences).to eq([:foo_name])
    end

    it "detects multiple sequences attribute defined" do
      factory = FactoryBurgers.factory_bot_adapter.factories.find(:factory_with_multiple_sequences)
      sequences = FactoryBurgers::Cheating.discover_sequences(factory)
      expect(Set.new(sequences)).to eq(Set.new(%i[bar_name baz_name qux_name]))
    end

    it "detects no sequence attributes defined" do
      factory = FactoryBurgers.factory_bot_adapter.factories.find(:factory_without_sequences)
      sequences = FactoryBurgers::Cheating.discover_sequences(factory)
      expect(sequences).to eq([])
    end
  end

  describe "doding uniqueness validations" do
    it "advances a sequence to avoid uniqueness validation" do
      klass = double
      allow(klass).to receive(:where).and_return(klass)
      allow(klass).to receive(:pluck).with(:foo).and_return(%w[foo1 foo5])

      FactoryBurgers::Cheating.advance_sequence(:sequence, klass, :foo)
      next_foo = generate(:sequence)
      expect(next_foo).to eq("foo6")
    end

    it "handles numeric behavior" do
      klass = double
      allow(klass).to receive(:where).and_return(klass)
      allow(klass).to receive(:pluck).with(:bar).and_return(%w[bar-9 bar-5 bar20])

      FactoryBurgers::Cheating.advance_sequence(:sequence_with_numeric_behavior, klass, :bar)
      next_bar = generate(:sequence_with_numeric_behavior)
      # Since, in general, we don't know how the sequence position is transformed into
      # the sequence value, the best we can robustly do for now is verify that something
      # is generated and it doesn't blow up.
      # A future iteration might send a probe into the sequence to collect all the methods
      # called and determine how to figure out what "next" should be
      # Here, however, we know that it will be `bar11` if the code works correctly,
      # because we'll iterate 20 times with the -10 offset
      expect(next_bar).to eq("bar11")
    end
  end
end
