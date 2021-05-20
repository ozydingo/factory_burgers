FactoryBurgers::Observation.register_link("User") do |object|
  {url: Rails.application.routes.url_helpers.user_path(object)}
end

FactoryBurgers::Observation.register_link("Post") do |object|
  {url: Rails.application.routes.url_helpers.post_path(object)}
end

# TODO: define a block evaluation context that can call all attributes of a
# factory and determine which invoke sequences, calling them on demand
FactoryBurgers::Cheating.advance_sequence(:user_login, User, :login)
FactoryBurgers::Cheating.advance_sequence(:user_email, User, :email)
