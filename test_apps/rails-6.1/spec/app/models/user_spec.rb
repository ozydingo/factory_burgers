require "rails_helper"

describe User do
  it "has a full name" do
    user = create :user, firstname: "first", lastname: "last"
    expect(user.full_name).to eq("first last")
  end
end
