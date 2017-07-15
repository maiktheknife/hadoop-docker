build:
	docker build -t ba/hadoop hadoop
	docker build -t ba/edge edge

up: build
	docker-compose up -d --remove-orphans --scale datanode_nodemanager=3

exc:
	docker cp examples/temperature hadoopdocker_edge_1:/opt/util/app/temperature
	docker cp examples/wordcount hadoopdocker_edge_1:/opt/util/app/wordcount

	docker-compose exec edge bash -c "chown -R hadoop:hadoop /opt/util/app"

	docker-compose exec --user hadoop edge bash

down:
	docker-compose down --remove-orphans

restart: down up

ps:
	docker-compose ps

logs:
	docker-compose logs

clean:
	docker system prune -f