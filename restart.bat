docker-compose down --remove-orphans
docker-compose up --build --force-recreate --remove-orphans --abort-on-container-exit
pause
