cd .\hadoop
call docker-build.bat

cd ..\edge
call docker-build.bat

cd ..
docker-compose up --remove-orphans --scale datanode_nodemanager=3