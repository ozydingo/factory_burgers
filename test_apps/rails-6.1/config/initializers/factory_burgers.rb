class FactoryBurgers::Presenters::UserPresenter < FactoryBurgers::Presenters::Base
  presents :user

  def attributes
    {
      id: user.id,
      name: user.full_name,
      login: user.login,
      email: user.email,
    }
  end

  def link_path
    Rails.application.routes.url_helpers.user_path(user)
  end
end

# Do one as a class...
FactoryBurgers::Presenters.present "User", with: FactoryBurgers::Presenters::UserPresenter

# And one as a block!
FactoryBurgers::Presenters.present("Post") do
  attributes do |post|
    {
      id: post.id,
      author_id: post.author_id,
      word_ccount: post.body.split(/\s+/).count,
    }
  end

  link_path { |post| Rails.application.routes.url_helpers.post_path(post) }
end

# TODO: define a block evaluation context that can call all attributes of a
# factory and determine which invoke sequences, calling them on demand
FactoryBurgers::Cheating.advance_sequence(:user_login, User, :login)
FactoryBurgers::Cheating.advance_sequence(:user_email, User, :email)
