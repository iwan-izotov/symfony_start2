DOCKER_COMPOSE_DIR=./docker
DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.env:
	cp $(DOCKER_COMPOSE_DIR)/.env.example .env

.PHONY:
create-env: .env ##Проверяет, если .env фалй не существует в корне проекта, то создаёт его на основе .env.example

.PHONY: docker-prune
docker-prune: ## Удаляет неиспользуемые ресурсы докера с помощью 'docker system prune -a -f --volumes'
	docker system prune -a -f --volumes

.PHONY: docker-up
docker-up: create-env ## Запускает все Docker-контейнеры в фоновом режиме
	docker-compose up -d --build

.PHONY: docker-down
docker-down: create-env ## Останвливает контейнеры и удаляет их
	docker-compose down

.PHONY: docker-down-volume
docker-down-volume: create-env ## Останвливает контейнеры, удаляет контенеры и ТОМА!!!
	docker-compose down -v

.PHONY: docker-build-from-scratch
docker-build-from-scratch: create-env ## Собирает все образы докера с нуля, без кеша
	docker-compose rm -fs && \
	docker-compose build --pull --no-cache --parallel && \
	docker-compose up -d --force-recreate

.PHONY: docker-build
docker-build: create-env ## Собирает все образы докера
	docker-compose build --parallel && \
	docker-compose up -d --force-recreate

.PHONY: console
console: ## Запускает bash на контейнере php-fpm (для запуска консольных команд)
	docker exec -it symfony_start_2_php_fpm bash
