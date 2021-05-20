describe FactoryBurgers::Introspection do
  it "lists defined factories" do
    factories = FactoryBurgers::Introspection.factories

    expect(factories).to be_present
    expect(factories.find { |f| f.name == :user }).to be_present
  end

  it "returns a list of associations and their factories for a given model" do
    factories = FactoryBurgers::Introspection.association_factories(User)
    posts_assoc = factories&.find { |f| f[:association].name == :posts }

    expect(posts_assoc).to be_present
    expect(posts_assoc[:factory].name).to eq(:post)
  end

  it "returns a list of factories for a class" do
    factories = FactoryBurgers::Introspection.factories_for_class(User)

    expect(factories).to be_present
    expect(factories.find { |f| f.name == :user }).to be_present
  end
end
