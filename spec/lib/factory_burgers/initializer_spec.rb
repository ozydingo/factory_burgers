describe FactoryBurgers::Initializer do
  let(:initialzer) do
    initializer = instance_double "Proc"
    allow(initializer).to receive(:call)
    initializer
  end

  before :each do
    # Reset to blank slate
    FactoryBurgers::Initializer.instance_eval do
      @initializers = []
      @initialized = false
    end
  end

  it "runs initializers" do
    FactoryBurgers::Initializer.add_initializer(initialzer)
    FactoryBurgers::Initializer.run_initializers
    expect(initialzer).to have_received(:call)
  end
end
