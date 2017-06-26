#!/usr/bin/env bash

hdfs dfs -rm -r /inputdir
hdfs dfs -rm -r /outputdir
hdfs dfs -mkdir /inputdir
hdfs dfs -put inputfile /inputdir
hdfs dfs -put inputfile_new /inputdir
hdfs dfs -ls /inputdir

spark-submit --master yarn --deploy-mode client --executor-memory 1g --name wordcount --conf "spark.app.id=wordcount" wordcount.py hdfs://namenode:8020/inputdir/inputfile_new hdfs://namenode:8020/outputdir