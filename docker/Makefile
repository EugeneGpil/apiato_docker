init:\
	build\
	up\
	perm\
 	init-back-env\
 	composer-install\
 	key-generate\
 	passport-keys\
 	docs-install\
 	perm\
 	db-migrate\
 	test

build:
	docker compose build

up:
	docker compose up --detach --remove-orphans --force-recreate

exec:
	docker compose exec --user=app php-fpm bash

down:
	docker compose down

perm:
	docker compose run php-fpm bash -cl \
		"/set_perm.sh app"

docs-install:
	docker compose run --user=app php-fpm bash -cl \
		"npm install"

composer-install:
	docker compose run --user=app php-fpm bash -cl \
		"composer install"

init-back-env:
	@if [ -e $$(test ! -f ../apiato/.env) ]; then\
  		cp .env.apiato.example ../apiato/.env;\
	fi

key-generate:
	@if [ -e $$(test ! -f ../apiato/.env || egrep "^APP_KEY=.+" ../apiato/.env) ]; then\
		docker compose run --user=app php-fpm bash -cl \
			"php artisan key:generate";\
	else\
		echo "APP_KEY is already set. Skipped.";\
	fi

passport-keys:
	docker compose run --user=app php-fpm bash -cl \
		"php artisan passport:keys | true"

db-migrate:
	docker compose run --user=app php-fpm bash -cl \
		"php artisan migrate"

node-exec:
	docker compose exec node bash

test:
	docker compose exec --user=app php-fpm bash -cl \
		"./vendor/bin/phpunit --stop-on-failure --stop-on-error --display-skipped ./app/"
