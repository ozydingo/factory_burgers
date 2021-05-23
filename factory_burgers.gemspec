Gem::Specification.new do |s|
  s.name        = 'factory_burgers'
  s.version     = '0.0.0'
  s.date        = '2021-04-20'
  s.summary     = "UI for thoughtbot/factory_bot"
  s.authors     = ["Andrew Schwartz"]
  s.email       = 'ozydingo@gmail.com'
  s.files       = Dir["lib/**/*"]
  s.homepage    = 'https://github.com/ozydingo/factory_burgers'
  s.license     = 'MIT'

  s.add_dependency "factory_bot", ">= 4"
  s.add_dependency "rack", ">= 1"

  s.add_development_dependency "activerecord", ">= 4"
  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "sqlite3"
end
