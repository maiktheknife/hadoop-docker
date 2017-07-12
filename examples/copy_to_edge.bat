docker cp temperature hadoopdocker_edge_1:/opt/util/app/temperature
docker cp wordcount hadoopdocker_edge_1:/opt/util/app/wordcount

rem fix permissions
docker-compose exec edge bash -c "chown -R hadoop:hadoop /opt/util/app"