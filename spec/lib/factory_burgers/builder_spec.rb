require "spec_helper"

describe FactoryBurgers::Builder do
  let(:builder) { FactoryBurgers::Builder.new }

  describe "build" do
    it "builds a resource" do
      user = builder.build(:user, [], {})
      expect(user).to be_persisted
    end

    it "can use a trait" do
      user = builder.build(:user, [:silly], {})
      expect(user.name.last).to eq("?")
    end

    it "can override attributes" do
      user = builder.build(:user, [], {name: "Sir Regynald J Bubblesworth"})
      expect(user.name).to eq("Sir Regynald J Bubblesworth")
    end

    context "with an owner" do
      let(:user) { create :user }
      let(:builder) { FactoryBurgers::Builder.new(user) }

      it "supports a belongs_to association" do
        group = builder.build(:group, [], {}, as: :group)
        expect(group.reload.users).to include(user)
        expect(user.reload.group).to eq(group)
      end

      it "supports a has_one association" do
        profile = builder.build(:profile, [], {}, as: :profile)
        expect(profile.reload.user).to eq(user)
        expect(user.reload.profile).to eq(profile)
      end

      it "supports a has_mmany association" do
        post = builder.build(:post, [], {}, as: :posts)
        expect(post.reload.author).to eq(user)
        expect(user.reload.posts).to include(post)
      end

      it "does not clobber existin has_many records" do
        existing_posts = create_list :post, 2
        user.posts << existing_posts
        post = builder.build(:post, [], {}, as: :posts)
        current_posts = user.reload.posts
        expect(current_posts).to include(existing_posts[0])
        expect(current_posts).to include(existing_posts[1])
        expect(current_posts).to include(post)
      end

      it "does not support a through association" do
        expect do
          builder.build(:star, [], {}, as: :stars)
        end.to raise_error(
          FactoryBurgers::Errors::InvalidAssociationError,
          /ThroughReflection association stars on User is not supported/
        )
      end

      it "builds inepedent resources without a specified association" do
        group = builder.build(:group, [], {})
        expect(group.reload.users).not_to include(user)
        expect(user.reload.group).not_to eq(group)
      end
    end
  end
end
