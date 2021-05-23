VERSION := $(shell ruby -r ./lib/factory_burgers/version.rb -e 'print FactoryBurgers::VERSION')

.PHONY: rspec rubocop eslint test gem clean publish

rspec:
	rspec

rubocop:
	rubocop lib
	rubocop spec

eslint:
	cd factory_burgers-ui; npm run lint

test: rubocop eslint rspec

assets:
	cd factory_burgers-ui; npm run build

clean:
	-rm factory_burgers-$(VERSION).gem

factory_burgers-$(VERSION).gem: assets test
	gem build factory_burgers.gemspec

gem: factory_burgers-$(VERSION).gem

publish: factory_burgers-$(VERSION).gem
	gem push factory_burgers-$(VERSION).gem
