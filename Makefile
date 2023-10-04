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
	docker rm $$(docker ps -qa)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker network rm $$(docker network ls -q)
	rm -rf $(DATA_PATH)

.PHONY: up build down clean

$(DATA_PATH):
	mkdir $(DATA_PATH)

$(DATA_PATH_MARIADB): $(DATA_PATH)
	mkdir $(DATA_PATH_MARIADB)

$(DATA_PATH_WORDPRESS): $(DATA_PATH)
	mkdir $(DATA_PATH_WORDPRESS)
