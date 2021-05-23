.PHONY: rspec rubocop eslint test

rspec:
	rspec

rubocop:
	rubocop lib
	rubocop spec

eslint:
	cd factory_burgers-ui; npm run lint

test: rubocop eslint rspec
