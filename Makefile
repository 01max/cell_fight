CAT_COMMAND:=$(shell type -p mdcat || echo cat)

install:
	@if ! [ -e .env ]; then cp _.env .env; fi
	@docker-compose build
	@docker-compose run web bundle exec rake db:create
	@docker-compose run web bundle exec rake db:migrate
	@docker-compose run web rake secret

seed:
	@docker-compose run web bundle exec rake db:seed

console:
	@docker-compose run web rails c

# —————

rspec:
	@docker-compose run web bundle exec rspec spec

# —————

help:
	@$(CAT_COMMAND) MAKE_HELP.md

h:
	@make help
