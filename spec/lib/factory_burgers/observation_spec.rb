describe FactoryBurgers::Observation do
  before :all do
    FactoryBurgers::Observation.purge!
  end

  after :each do
    FactoryBurgers::Observation.purge!
  end

  it "returns a url and default name for an object" do
    FactoryBurgers::Observation.register_link("User") do |obj|
      {url: "url/for/user/#{obj.id}"}
    end
    user = create :user
    link = FactoryBurgers::Observation.app_link(user)

    expect(link[:label]).to eq(FactoryBurgers::Observation.default_label(user))
    expect(link[:url]).to eq("url/for/user/#{user.id}")
  end

  it "includes class, id, and name if available in the default name" do
    user = create :user
    label = FactoryBurgers::Observation.default_label(user)

    expect(label).to include("User")
    expect(label).to include(user.id.to_s)
    expect(label).to include(user.name)
  end

  it "handles link data not found" do
    user = create :user
    link = FactoryBurgers::Observation.app_link(user)
    expect(link).to be_nil
  end

  it "uses a specified label" do
    FactoryBurgers::Observation.register_link("User") do |obj|
      {
        url: "url/for/user/#{obj.id}",
        label: "the user named #{obj.name}",
      }
    end
    user = create :user
    link = FactoryBurgers::Observation.app_link(user)

    expect(link[:label]).to eq("the user named #{user.name}")
  end

  it "allows extra arguments for links" do
    FactoryBurgers::Observation.register_link("User") do |obj, suffix|
      {
        url: "url/for/user/#{obj.id}/#{suffix}",
      }
    end
    user = create :user
    link = FactoryBurgers::Observation.app_link(user, "xyz")

    expect(link[:url]).to eq("url/for/user/#{user.id}/xyz")
  end
end
