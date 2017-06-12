#!/usr/bin/env bash

# docker exec -u hdfsuser 
# or
# sudo -u $HDFS_USER command

hdfs dfs -put data.txt /data.txt
hdfs dfs -ls /

## new
hdfs dfs -mkdir /inputdir
hdfs dfs -mkdir /outputdir
hdfs dfs -put sample.txt /inputdir
hdfs dfs -ls /inputdir