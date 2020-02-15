SHELL := /usr/bin/env bash

include .env

initdb:
	createuser -s -P ${DB_USER}

createdb:
	createdb ${DB_USER} -O ${DB_USER}

dropdb:
	dropdb ${DB_USER}

makemigrate:
	web/manage.py makemigrations

migrate:
	web/manage.py migrate

runserver:
	web/manage.py runserver 127.0.0.1:5000

pip:
	pip install -r requirements.txt

start:
	yarn --cwd web/app start

build:
	yarn --cwd web/app build

install:
	yarn --cwd web/app install

freeze:
	pip freeze > requirements.txt

shell:
	web/manage.py shell_plus

deploy:
	# git stash -u
	yarn --cwd ./web/app install
	yarn --cwd ./web/app build
	make sync
	ssh -i ~/.ssh/google_compute_engine ${REMOTE_USER}@${REMOTE_HOST} "pip install -r ${PROJECT_NAME}/requirements.txt && ${PROJECT_NAME}/web/manage.py migrate" -i ~/.ssh/google_compute_engine
	# git stash pop

sync:
	rsync --delete -avzr -e "ssh -i ~/.ssh/google_compute_engine" --include=web --include=web/* --include=web/app --include=web/app/build/ --include=web/app/build/* --exclude='web/app/*' --filter=':- .gitignore' . ${REMOTE_USER}@${REMOTE_HOST}:/home/${REMOTE_USER}/${PROJECT_NAME}

ssh-gcloud:
	gcloud beta compute --project ${GCLOUD_PROJECT} ssh --zone "us-west1-b" ${PROJECT_NAME}

ssh:
	ssh ${REMOTE_USER}@${REMOTE_HOST} -i ~/.ssh/google_compute_engine
