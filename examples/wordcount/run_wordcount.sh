#!/usr/bin/env bash

# upload data to HDFS
hdfs dfs -rm -r /inputdir /outputdir
hdfs dfs -mkdir /inputdir
hdfs dfs -put inputfile_new /inputdir
hdfs dfs -ls /inputdir

# run application
spark-submit --master yarn --deploy-mode cluster wordcount.py /inputdir/inputfile_new /outputdir

# get results from HDFS
hdfs dfs -tail /outputdir/part-00000