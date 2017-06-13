#!/usr/bin/env bash

# docker exec -u hdfsuser 
# or
# sudo -u $HDFS_USER command

hdfs dfs -mkdir /inputdir
hdfs dfs -put file01 /inputdir
hdfs dfs -put file02 /inputdir
hdfs dfs -ls /inputdir
