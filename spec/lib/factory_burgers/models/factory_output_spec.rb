describe FactoryBurgers::Models::FactoryOutput do
  let(:user) { create :user }
  let(:output) { FactoryBurgers::Models::FactoryOutput.new(user) }
  let(:output_data) { output.data }

  # TODO: this model needs to work

  it "builds data" do
    expect(output_data[:type]).to eq("User")
    expect(output_data[:attributes]).to eq({"id" => user.id, "name" => user.name})
    expect(output_data).to include(:link)
    expect(output_data[:link]).to be_nil
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
end
