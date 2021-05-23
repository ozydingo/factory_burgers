require "spec_helper"

describe FactoryBurgers::Builder do
  let(:builder) { FactoryBurgers::Builder.new }

  describe "build" do
    it "builds a resource" do
      user = builder.build(:user, [], {}, nil)
      expect(user).to be_persisted
    end

    it "can use a trait" do
      user = builder.build(:user, [:silly], {}, nil)
      expect(user.name.last).to eq("?")
    end

    it "can override attributes" do
      user = builder.build(:user, [], {name: "Sir Regynald J Bubblesworth"}, nil)
      expect(user.name).to eq("Sir Regynald J Bubblesworth")
    end

    # This is currently borked
    skip "specifying an owner" do
      context "when the owner is a belongs_to association" do
        it "sets the resource's owner" do
          group = Group.create!
          builder.build(:user, [], {name: "Sir Regynald J Bubblesworth"}, group)
        end
      end

      context "when the owner is a has_one association" do
        it "sets the resource's owner" do
          profile = UserProfile.create!
          builder.build(:user, [], {name: "Sir Regynald J Bubblesworth"}, profile)
        end
      end

      context "when the owner is a has_many association" do
        it "sets the resource's owner" do
          post = create :post
          builder.build(:user, [], {name: "Sir Regynald J Bubblesworth"}, post)
        end
      end
    end
  end
end
