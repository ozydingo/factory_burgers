describe FactoryBurgers::SequenceInjector do
  let(:injector) { described_class.new("foo") }

  it "injects a string value" do
    expect("Hello, #{injector}!").to eq("Hello, foo!")
  end

  it "skips over methods" do
    expect("Hello, #{(injector - 40).sublimate}!").to eq("Hello, foo!")
  end
end
