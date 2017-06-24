:: docker-compose up --build --remove-orphans --abort-on-container-exit
:: docker-compose up --build --force-recreate --remove-orphans --abort-on-container-exit

cd hadoop
call docker-build.bat

cd ..\spark
call docker-build.bat

cd ..
docker-compose up --remove-orphans