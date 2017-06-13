:: docker rmi $(docker images -a -q)
:: docker rm $(docker ps -a -f status=exited -q)
docker volume prune
docker system prune
