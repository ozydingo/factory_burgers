describe FactoryBurgers do
  describe "loaded" do
    let(:recorder) do
      recorder = instance_double "Proc"
      allow(recorder).to receive(:call)
      recorder
    end

    before :each do
      # Reset to blank slate
      FactoryBurgers::Initializer.instance_eval do
        @initializers = []
        @initialized = false
      end
      FactoryBurgers.factory_bot_adapter.instance_eval do
        @loaded = false
      end
    end

    it "runs initailization code after the adapter is called" do
      FactoryBurgers.loaded do
        recorder.call
      end
      FactoryBurgers.factory_bot_adapter.factories
      expect(recorder).to have_received(:call)
    end

    it "does not runs initailization code before the adapter is called" do
      FactoryBurgers.loaded do
        recorder.call
      end
      expect(recorder).not_to have_received(:call)
    end
  end
end
