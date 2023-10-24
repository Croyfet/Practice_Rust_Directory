DOCKER_COMPOSE_FILE_DEFAULT=./docker/docker-compose.yaml
DOCKER_COMPOSE_FILE_MOLD=./docker/mold.docker-compose.yaml

DOCKER_COMPOSE_FILE=${DOCKER_COMPOSE_FILE_DEFAULT}

.PHONY: up down stop ps volume exec ubuntu

all: build up

build:
	@echo "docker compose build"
	@docker compose -f ${DOCKER_COMPOSE_FILE} build --build-arg OS_UID="$$(id -u)" --build-arg OS_GID="$$(id -g)" --build-arg OS_GROUPNAME="$${USER}" --build-arg OS_USERNAME="$${USER}"

up:
	@echo "docker compose up -d"
	@docker compose -f ${DOCKER_COMPOSE_FILE} up -d

down:
	@echo "docker compose down --volumes --rmi local"
	@docker compose -f ${DOCKER_COMPOSE_FILE} down --volumes --rmi local

stop: down

ps:
	@echo "docker compose ps -a"
	@docker compose -f ${DOCKER_COMPOSE_FILE} ps -a

volume:
	docker volume ls

exec:
	@echo "docker compose exec rust /bin/bash"
	@docker compose -f ${DOCKER_COMPOSE_FILE} exec rust /bin/bash

rust: exec
