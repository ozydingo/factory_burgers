require "date"
require File.expand_path('./lib/factory_burgers/version')

Gem::Specification.new do |s|
  s.name        = 'factory_burgers'
  s.version     = FactoryBurgers::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Bring the power of thoughtbot/factory_bot to manual testing"
  s.description = "factory_burgers provides a UI and some tooling to allow manual testing the abilit to use all of your factories."
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
