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

stop:
	docker-compose stop

down:
	docker-compose down --remove-orphans

restart: stop up

ps:
	docker-compose ps

logs:
	docker-compose logs

clean:
	docker system prune -f

swarm_up: build
	docker swarm init
	docker stack deploy --compose-file docker-stack.yml ba_stack

swarm_down:
	docker stack rm ba_stack
	docker swarm leave --force

swarm_restart: swarm_down swarm_up

swarm_ps:
	docker stack services ba_stack

swarm_logs:
	docker service logs ba_stack_namenode
	docker service logs ba_stack_resourcemanager
	docker service logs ba_stack_datanode_nodemanager
