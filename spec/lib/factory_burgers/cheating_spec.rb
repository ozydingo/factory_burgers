require "rails_helper"

FactoryBot.define do
  factory :factories_cheating_spec_factory_without_sequences, class: "Object" do
    foo { 1 }
    bar { 2 }
    baz { 3 }
    qux { 4 }
  end

  factory :factories_cheating_spec_factory_with_one_sequence, class: "Object" do
    foo { generate :foo_name }
    bar { 2 }
    baz { 3 }
    qux { 4 }
  end

  factory :factories_cheating_spec_factory_multiple_sequences, class: "Object" do
    foo { 1 }
    bar { generate :bar_name }
    baz { generate :baz_name }
    qux { generate :qux_name }
  end

  sequence :factories_cheating_fake_model_sequence do |n|
    "foo#{n}"
  end

  sequence :factories_cheating_fake_model_sequence_with_numeric_behavior do |n|
    "bar#{n - 10}"
  end

  factory :factories_cheating_fake_model, class: "Object" do
    foo { generate :factories_cheating_fake_model_sequence }
    bar { generate :factories_cheating_fake_model_sequence_with_numeric_behavior }
  end
end

describe Factories::Cheating do
  describe "discover_sequences" do
    it "detects one sequence attribute defined" do
      factory = FactoryBot.factories.find(:factories_cheating_spec_factory_with_one_sequence)
      sequences = Factories::Cheating.discover_sequences(factory)
      expect(sequences).to eq([:foo_name])
    end

    it "detects multiple sequences attribute defined" do
      factory = FactoryBot.factories.find(:factories_cheating_spec_factory_multiple_sequences)
      sequences = Factories::Cheating.discover_sequences(factory)
      expect(Set.new(sequences)).to eq(Set.new([:bar_name, :baz_name, :qux_name]))
    end

    it "detects no sequence attributes defined" do
      factory = FactoryBot.factories.find(:factories_cheating_spec_factory_without_sequences)
      sequences = Factories::Cheating.discover_sequences(factory)
      expect(sequences).to eq([])
    end
  end

  describe "doding uniqueness validations" do
    it "advances a sequence to avoid uniqueness validation" do
      klass = double
      allow(klass).to receive(:where).and_return(klass)
      allow(klass).to receive(:pluck).with(:foo).and_return(["foo1", "foo5"])

      next_foo = Factories::Cheating.advance_sequence(:factories_cheating_fake_model_sequence, klass, :foo)
      expect(next_foo).to eq("foo6")
    end

    it "handles numeric behavior" do
      klass = double
      allow(klass).to receive(:where).and_return(klass)
      allow(klass).to receive(:pluck).with(:bar).and_return(["bar-9", "bar-5", "bar20"])

      next_bar = Factories::Cheating.advance_sequence(:factories_cheating_fake_model_sequence_with_numeric_behavior, klass, :bar)
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
