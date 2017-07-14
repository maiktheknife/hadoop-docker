cd .\hadoop
call docker-build.bat

cd ..\edge
call docker-build.bat

cd ..
docker-compose up --remove-orphans  --abort-on-container-exit --scale datanode_nodemanager=3