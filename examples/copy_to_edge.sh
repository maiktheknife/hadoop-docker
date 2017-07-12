#!/usr/bin/env bash

docker cp temperature hadoopdocker_edge_1:/opt/util/app/temperature
docker cp wordcount hadoopdocker_edge_1:/opt/util/app/wordcount

# fix permissions
docker-compose exec edge bash -c "chown -R hadoop:hadoop /opt/util/app"
