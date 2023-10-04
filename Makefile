DATA_PATH=/home/gmallet/data
DATA_PATH_WORDPRESS=$(DATA_PATH)/wordpress
DATA_PATH_MARIADB=$(DATA_PATH)/mariadb
COMPOSE_FILEPATH=./srcs/docker-compose.yml

up: $(DATA_PATH_WORDPRESS) $(DATA_PATH_MARIADB) build
	docker compose --file $(COMPOSE_FILEPATH) up -d

build:
	docker compose --file $(COMPOSE_FILEPATH) build

down:
	docker compose --file $(COMPOSE_FILEPATH) down

fclean: down
	docker system prune --volumes --all --force
	docker network prune --force
	docker volume prune --force
	docker image prune --force
	sudo rm -rf $(DATA_PATH)

.PHONY: up build down clean

$(DATA_PATH):
	mkdir $(DATA_PATH)

$(DATA_PATH_MARIADB): $(DATA_PATH)
	mkdir $(DATA_PATH_MARIADB)

$(DATA_PATH_WORDPRESS): $(DATA_PATH)
	mkdir $(DATA_PATH_WORDPRESS)
