#!/usr/bin/env bash

# docker exec --user hadoop
# or
# sudo -u $HDFS_USER command

# generate test data
./generate_dump.py

# upload data to HDFS
hdfs dfs -rm -r /years /years_out
hdfs dfs -put years/ /years
hdfs dfs -ls /

# build application
cd prototyp
mvn clean package

# run application
hadoop jar target/hadoop-prototyp-1.0-SNAPSHOT.jar de.menzel.hadoop.temperature.TemperatureAggregator hdfs://namenode:8020/years hdfs://namenode:8020/years_out

# get result from HDFS
hdfs dfs -get /years_out years_out
more years_out/part-r-00000
