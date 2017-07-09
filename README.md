# Apache Hadoop Docker Image

An [Apache Hadoop](http://hadoop.apache.org) container image. 
It's not useful to run a single image, better create a Cluster with Docker Compose or Docker Swarm.

#### Setup
```sh
git config core.eol lf
git config core.autocrlf input
```
___

## Custom commands
This image contains a script named `start-hadoop` (included in the PATH). 
This script is used to initialize NameNodes, DataNode, ResourceManager and NodeMangers.
The script supports running as a daemon if the `daemon` argument is passed as the last argument. 
This is useful when another command must be used or when the image is being used as the base for another image. 

### Starting the NameNode
To start a NameNode run the following command:
```sh
start-hadoop namenode [daemon]
```

### Starting the ResourceManager
To start a ResourceManager run the following command:
```sh
start-hadoop resourcemanager [daemon]
```

### Starting a DataNode and NodeManager
To start a DataNode/NodeManager at the same Container run the following command:
```sh
start-hadoop datanode [daemon]
```

___

## Creating a standalone cluster with Docker Compose
The easiest way to create a standalone cluster with this image is by using [Docker Compose](https://docs.docker.com/compose) with `docker-compose.yml`.
### Start 
This start the Cluster run the following command:
```sh
docker-compose up --remove-orphans --scale datanode_nodemanager=3
```
A Cluster should contain at least 3 DataNodes/NodeManagers. The new nodes will automatically register themselves with the NameNode. 
If you wish to increase the number of DataNodes/NodeManagers change the `--scale datanode_nodemanager` **value**  and run the start command again.
You can run the command multiply times to achieve dynamic scaling.

### Connect to NameNode
```sh
docker-compose exec --user hadoop namenode bash
```

### Stop
To stop the whole Cluster run the following command:
```sh
docker-compose down --remove-orphans
```

___

## Creating a multiple host cluster with Docker Swarm

### Start
This start the Cluster run the following command:
```sh
docker swarm init
docker stack deploy --compose-file docker-stack.yml ba_stack
```

### Check services
```sh
# listings
docker stack services ba_stack

# logs
docker service logs ba_stack_namenode
docker service logs ba_stack_datanode
docker service logs ba_stack_resourcemanager 
docker service logs ba_stack_spark
```

### Connect
```sh
docker exec -it --user hadoop <ContinerID> bash
```

### Stop
To stop the whole Cluster run the following command:
```sh
docker stack rm ba_stack
docker swarm leave --force
```

___

## Persistence

The image has a volume mounted at `/opt/hdfs`. To maintain states between restarts, mount a volume at this location.
This should be done for the NameNode and the DataNodes.
