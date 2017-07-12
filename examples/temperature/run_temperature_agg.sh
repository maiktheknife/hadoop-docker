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

# run application
yarn jar hadoop-prototyp-1.0-SNAPSHOT.jar de.menzel.hadoop.temperature.TemperatureAggregator /years /years_out

# check status and read results
hdfs dfs -test -e /years_out/_SUCCESS
if [ $? = 0 ]
then
    echo "Success, get results"
    hdfs dfs -tail /years_out/part-r-00000
else
    echo "Error, no results to read"
fi
