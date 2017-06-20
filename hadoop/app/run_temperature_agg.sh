#!/usr/bin/env bash

# docker exec -u hdfsuser 
# or
# sudo -u $HDFS_USER command

./generate_dump.py

hdfs dfs -rm -r /years
hdfs dfs -rm -r /years_out
hdfs dfs -put years/ /years
hdfs dfs -ls /

cd prototyp
mvn clean package

hadoop jar target/hadoop-prototyp-1.0-SNAPSHOT.jar de.menzel.hadoop.temperature.TemperatureAggregator hdfs://namenode:8020/years hdfs://namenode:8020/years_out

hdfs dfs -copyToLocal /years_out/part-r-*
more part-r-00000
