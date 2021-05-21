describe FactoryBurgers::Models::FactoryOutput do
  let(:user) { create :user }
  let(:output) { FactoryBurgers::Models::FactoryOutput.new(user) }
  let(:output_data) { output.data }

  # TODO: this model needs to work

  it "builds data" do
    expect(output_data[:type]).to eq("User")
    expect(output_data[:attributes]).to eq(user.attributes)
  end

  describe "association_factories" do
    let(:association_factories) { output_data[:association_factories] }

    it "includes all buildable associations" do
      expect(association_factories).to include({
        association_name: "posts",
        factory_name: "post",
      })
      expect(association_factories).to include({
        association_name: "group",
        factory_name: "group",
      })
    end
  end

  describe "link" do
    before do
      allow(FactoryBurgers::Observation).to receive(:app_link).with(user).and_return(
        {url: "path/to/user"}
      )
    end

    let(:link) { output_data[:link] }

    it "returns the link" do
      expect(link).to include({url: "path/to/user"})
    end
  end
end
