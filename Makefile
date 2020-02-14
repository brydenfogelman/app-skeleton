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
