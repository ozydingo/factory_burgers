require "rails_helper"

describe Factories::Introspection do
  it "lists defined factories" do
    factories = Factories::Introspection.factories

    expect(factories).to be_present
    expect(factories.find { |f| f.name == :account }).to be_present
  end

  it "returns a list of associations and their factories for a given model" do
    factories = Factories::Introspection.association_factories(Account)
    projects_assoc = factories&.find { |f| f[:association].name == :projects }

    expect(projects_assoc).to be_present
    expect(projects_assoc[:factory].name).to eq(:project)
  end

  it "returns a list of factories for a class" do
    factories = Factories::Introspection.factories_for_class(Account)

    expect(factories).to be_present
    expect(factories.find { |f| f.name == :account }).to be_present
  end
end
