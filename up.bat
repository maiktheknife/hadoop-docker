cd .\hadoop
call docker-build.bat

cd ..\spark
call docker-build.bat

cd ..\testapp
call docker-build.bat

cd ..
docker-compose up --remove-orphans --scale datanode_nodemanager=3