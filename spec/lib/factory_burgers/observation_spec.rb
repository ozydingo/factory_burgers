require "rails_helper"

describe Factories::Observation do
  before :all do
    Factories::Observation.purge!
  end

  after :each do
    Factories::Observation.purge!
  end

  it "returns a url and default name for an object" do
    Factories::Observation.register_link("Account") do |obj|
      {url: "url/for/account/#{obj.id}"}
    end
    account = create :account
    link = Factories::Observation.app_link(account)

    expect(link[:label]).to eq(Factories::Observation.default_label(account))
    expect(link[:url]).to eq("url/for/account/#{account.id}")
  end

  it "includes class, id, and name if available in the default name" do
    account = create :account
    label = Factories::Observation.default_label(account)

    expect(label).to include("Account")
    expect(label).to include(account.id.to_s)
    expect(label).to include(account.name)
  end

  it "handles link data not found" do
    account = create :account
    link = Factories::Observation.app_link(account)
    expect(link).to be_nil
  end

  it "uses a specified label" do
    Factories::Observation.register_link("Account") do |obj|
      {
        url: "url/for/account/#{obj.id}",
        label: "the account named #{obj.name}",
      }
    end
    account = create :account
    link = Factories::Observation.app_link(account)

    expect(link[:label]).to eq("the account named #{account.name}")
  end

  it "allows extra arguments for links" do
    Factories::Observation.register_link("Account") do |obj, suffix|
      {
        url: "url/for/account/#{obj.id}/#{suffix}",
      }
    end
    account = create :account
    link = Factories::Observation.app_link(account, "xyz")

    expect(link[:url]).to eq("url/for/account/#{account.id}/xyz")
  end
end
