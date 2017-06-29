#!/usr/bin/env bash

# upload data to HDFS
hdfs dfs -rm -r /inputdir /outputdir
hdfs dfs -mkdir /inputdir
hdfs dfs -put inputfile inputfile_new /inputdir
hdfs dfs -ls /inputdir

# run application
spark-submit --master yarn --deploy-mode cluster --executor-memory 1g --conf "spark.app.id=wordcount" wordcount.py hdfs://namenode:8020/inputdir/inputfile_new hdfs://namenode:8020/outputdir

# get result from HDFS
hdfs dfs -get /outputdir outputdir
more outputdir/part-00000
