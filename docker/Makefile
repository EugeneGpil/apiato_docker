init: build up init-backend-env composer-install key-generate passport-keys perm db-migrate

build:
	docker compose build

up:
	docker compose up --detach --remove-orphans --force-recreate

exec:
	docker compose exec --user=app php-fpm bash

stop:
	docker compose stop

perm:
	docker compose run php-fpm bash -cl \
		"/set_perm.sh app"

composer-install:
	docker compose run --user=app php-fpm bash -cl \
		"composer install"

init-backend-env:
	cp ./containers/dev/.env ../apiato/.env

key-generate:
	docker compose run --user=app php-fpm bash -cl \
		"php artisan key:generate"

passport-keys:
	docker compose run --user=app php-fpm bash -cl \
		"php artisan passport:keys"

db-migrate:
	docker compose run --user=app php-fpm bash -cl \
		"php artisan migrate"
