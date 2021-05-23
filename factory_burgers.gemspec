require "date"
require File.expand_path('./lib/factory_burgers/version')

Gem::Specification.new do |s|
  s.name        = 'factory_burgers'
  s.version     = FactoryBurgers::VERSION
  s.date        = Date.today.to_s
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
  s.add_development_dependency "rubocop-rspec"
  s.add_development_dependency "sqlite3"
end
