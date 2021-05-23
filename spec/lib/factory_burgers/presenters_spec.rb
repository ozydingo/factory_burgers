describe FactoryBurgers::Presenters do
  # NOTE: if ever we develop a default set of presenters,
  # we will need to be more careful than just to `purge!`
  before :all do # rubocop:disable RSpec/BeforeAfterAll; this is not a db action
    FactoryBurgers::Presenters.purge!
  end

  after :each do
    FactoryBurgers::Presenters.purge!
  end

  describe "defaults" do
    let(:user) { create :user, name: "Foo", login: "foobar" }
    let(:data) { FactoryBurgers::Presenters.data_for(user) }

    it "uses the default class" do
      expect(data[:type]).to eq("User")
      expect(Set.new(data[:attributes].keys)).to eq(Set.new(%w[id name]))
      expect(data[:link]).to be_nil
    end
  end

  describe "present with class" do
    before :each do
      FactoryBurgers::Presenters.present("User", with: FactoryBurgers::Presenters::ExamplePresenter)
    end

    context "when the object is of the same class" do
      let(:user) { create :user, name: "Foo", login: "foobar" }
      let(:user_data) { FactoryBurgers::Presenters.data_for(user) }

      it "uses the presenter class" do
        expect(user_data[:type]).to eq("An example")
        expect(user_data[:link]).to eq("link/to/foobar")
      end
    end

    context "when the object is a subclass" do
      let(:admin) { create :admin, name: "Admin Foo", login: "foobar!" }
      let(:admin_data) { FactoryBurgers::Presenters.data_for(admin) }

      it "uses the presenter class" do
        expect(admin_data[:type]).to eq("An example")
        expect(admin_data[:link]).to eq("link/to/foobar!")
      end
    end

    context "when the object is not the class or a subclass" do
      let(:post) { create :post }
      let(:post_data) { FactoryBurgers::Presenters.data_for(post) }

      it "uses the default base presenter" do
        expect(post_data[:type]).to eq("Post")
        expect(post_data[:link]).to be_nil
      end
    end
  end

  describe "present with block" do
    let(:user) { create :user, name: "Foo" }
    let(:data) { FactoryBurgers::Presenters.data_for(user) }

    it "defines a presenter" do
      FactoryBurgers::Presenters.present("User") do
        type { |user| "A user named #{user.name}" }
        link_path { |user| "path/to/user/#{user.id}/profile" }
      end

      expect(data[:type]).to eq("A user named Foo")
      expect(data[:link]).to eq("path/to/user/#{user.id}/profile")
    end

    it "uses default values" do
      FactoryBurgers::Presenters.present("User") do
        attributes { |user| {id: user.id} }
      end

      expect(data[:type]).to eq("User")
      expect(data[:link]).to be_nil
    end
  end
end
