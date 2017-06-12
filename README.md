# Apache Hadoop

An [Apache Hadoop](http://hadoop.apache.org) container image. This image is meant to be used for creating a standalone cluster with multiple DataNodes.

## Custom commands

This image contains a script named `start-hadoop` (included in the PATH). This script is used to initialize NamaNodes and DataNodes.

### HDFS user

The custom commands require an HDFS user to be set. The user's name if read from the `HDFS_USER` environment variable and the user is automatically created by the commands.

### Starting a NameNode

To start a NameNode run the following command:

```sh
start-hadoop namenode
```

The script supports running as a daemon if the `daemon` argument is passed as the last argument. This is useful when another command must be used or when the image is being used as the base for another image. To run a NameNode as a daemon use the following command:

```sh
start-hadoop namenode daemon
```

### Starting a DataNode

To start a DataNode run the following command:

```sh
start-hadoop datanode [NameNode]
```

The script supports running as a daemon if the `daemon` argument is passed as the last argument. This is useful when another command must be used or when the image is being used as the base for another image. To run a NameNode as a daemon use the following command:

```sh
start-hadoop datanode [NameNode] daemon
```

## Creating a cluster with Docker Compose

The easiest way to create a standalone cluster with this image is by using [Docker Compose](https://docs.docker.com/compose) with `docker-compose.yml` for a simple cluster.

### Persistence

The image has a volume mounted at `/opt/hdfs`. To maintain states between restarts, mount a volume at this location. This should be done for the NameNode and the DataNodes.

### Scaling

If you wish to increase the number of DataNodes scale the `datanode` service by running the `scale` command like follows:

```sh
docker-compose scale datanode=2
```

The DataNodes will automatically register themselves with the NameNode.
