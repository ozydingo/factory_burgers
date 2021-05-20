describe FactoryBurgers::SequenceCheater do
  let(:cheater) { described_class.new }

  it "collects occurences of `generate`" do
    cheater.instance_eval do
      foo
      bar
      generate :baz
      generate :qux
      generate :qux
    end

    expect(Set.new(cheater.sequence_names)).to eq(Set.new([:baz, :qux]))
  end
end
