# Apache Hadoop

An [Apache Hadoop](http://hadoop.apache.org) container image. 
This image is meant to be used for creating a standalone cluster with multiple (<= 3) DataNodes.


## Setup
```sh
git config core.eol lf
git config core.autocrlf input
```

## Custom commands
This image contains a script named `start-hadoop` (included in the PATH). 
This script is used to initialize NameNodes, DataNode, ResourceManager and NodeMangers.

### Starting a NameNode and ResourceManager
To start a NameNode run the following command:
```sh
start-hadoop namenode [daemon]
```
The script supports running as a daemon if the `daemon` argument is passed as the last argument. 
This is useful when another command must be used or when the image is being used as the base for another image. 

### Starting a DataNode and NodeManager
To start a DataNode run the following command:
```sh
start-hadoop datanode [daemon]
```
The script supports running as a daemon if the `daemon` argument is passed as the last argument. 
This is useful when another command must be used or when the image is being used as the base for another image. 


## Persistence

The image has a volume mounted at `/opt/hdfs`. To maintain states between restarts, mount a volume at this location.
This should be done for the NameNode and the DataNodes.


## Creating a cluster with Docker Compose
The easiest way to create a standalone cluster with this image is by using [Docker Compose v3](https://docs.docker.com/compose) with `docker-compose.yml`.

### Scaling
If you wish to increase the number of DataNodes scale the `datanode` service by running the `scale` command like follows:
```sh
docker-compose scale datanode=5
```
The DataNodes will automatically register themselves with the NameNode.

### Start 
This start the NameNode and  and one DataNodes
```sh
docker-compose up --build --remove-orphans --abort-on-container-exit
```
Now, scale it up to 3 DataNodes and NodeManagers
```sh
docker-compose scale datanode=3
```

### Connect to NameNode
```sh
docker-compose exec --user hadoop namenode bash
```

### Stop 
```sh
docker-compose down --remove-orphans
```
