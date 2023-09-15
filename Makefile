up:
	docker compose up -d

down:
	docker compose down --remove-orphans

down-clear:
	docker compose down --remove-orphans --volumes

pull:
	docker compose pull

build:
	docker compose build

composer-install:
	docker compose run --rm api-php-cli composer install

composer-dump:
	docker compose run --rm api-php-cli composer dump-autoload

copy-env:
	docker compose run --rm api-php-cli composer run post-root-package-install

key-generate:
	docker compose run --rm api-php-cli php artisan key:generate

storage-link:
	docker compose run --rm api-php-cli php artisan storage:link

permissions:
	sudo chmod -R ug+rwx api/storage api/bootstrap/cache
	sudo chgrp -R 1000 api/storage api/bootstrap/cache

tinker:
	docker compose run --rm api-php-cli php artisan tinker

migrate:
	docker compose run --rm api-php-cli php artisan migrate --path=/database/migrations/shared
	docker compose run --rm api-php-cli php artisan migrate --path=/database/migrations/auth
	docker compose run --rm api-php-cli php artisan migrate --path=/database/migrations/finance
	docker compose run --rm api-php-cli php artisan migrate

migrate-last:
	docker compose run --rm api-php-cli php artisan migrate

migrate-rollback:
	docker compose run --rm api-php-cli php artisan migrate:rollback

migrate-fresh:
	docker compose run --rm api-php-cli php artisan migrate:fresh

migrate-fresh-seed:
	docker compose run --rm api-php-cli php artisan migrate:fresh --seed

ide-helper-models:
	docker compose run --rm api-php-cli php artisan ide-helper:models -M

app-init: composer-install copy-env key-generate storage-link migrate

init: down-clear pull build up app-init

init-wo-pull: down-clear build up app-init

pre-permissions:
	sudo chown -R ${USER}:${USER} api

restart: down up

cache-clear:
	sudo rm -rf ./bootstrap/cache/*
	sudo chmod -R ug+rwx api/storage api/bootstrap/cache
	docker compose run --rm api-php-cli php artisan cache:clear
	docker compose run --rm api-php-cli php artisan config:cache
