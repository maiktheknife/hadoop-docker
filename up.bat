:: docker stack deploy does not support build, so we use pre-built images

cd hadoop
call docker-build.bat

cd ..\spark
call docker-build.bat

cd ..
docker swarm init
docker stack deploy --compose-file docker-compose.yml ba_stack

:: listings
docker stack services ba_stack

:: logs
docker service logs ba_stack_namenode
docker service logs ba_stack_datanode
docker service logs ba_stack_spark
