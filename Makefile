.DEFAULT_GOAL := default
SHELL := /bin/bash

manage_command = docker exec -it project-name-app /manage.sh


default:
	@echo "Please specify target. Check contents of Makefile to see list of available targets."

make setup_project:
	docker build -t project-name-app -f docker/app/Dockerfile .
	docker build -t project-name-db -f docker/db/Dockerfile .
	cd docker/ && docker compose up -d db
	cd docker/ && docker compose up -d app
	make prepare_database
	@echo "Waiting 20 seconds for database in db container to be connectible..."
	@sleep 20
	make migrate
	make create_default_superuser
	make down
	@echo "The project setup has been completed successfully. Now you can run 'make up' to start the project."

prepare_database:
	docker exec -it project-name-db /db-init.sh

makemigrations:
	$(manage_command) makemigrations -n '_' $(options) web
	docker exec -it project-name-app /fix-privileges.sh /opt/project-name/src/web/migrations

makemigrations_data:
	$(manage_command) makemigrations -n '_' --empty web
	docker exec -it project-name-app /fix-privileges.sh /opt/project-name/src/web/migrations

migrate:
	$(manage_command) migrate $(app) $(migration)

create_default_superuser:
	$(manage_command) createsuperuser --noinput

pip_install:
	docker exec -it project-name-app docker/app/pip.sh

app_bash:
	docker exec -it project-name-app bash

django_shell:
	$(manage_command) shell

test:
	$(manage_command) test

manage:
	$(manage_command) $(command)

up:
	cd docker/ && docker compose up

down:
	cd docker/ && docker compose down
