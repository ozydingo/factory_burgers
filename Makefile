.PHONY: rspec rubocop eslint test gem clean

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
	-rm release.gem

release.gem: assets test clean
	gem build factory_burgers.gemspec --output release.gem

gem: release.gem

publish: release.gem
	gem push release.gem
