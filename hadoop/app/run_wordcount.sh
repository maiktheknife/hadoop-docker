#!/usr/bin/env bash

hdfs dfs -rm -r /inputdir
hdfs dfs -rm -r /outputdir
hdfs dfs -put wordcount/file01 /inputdir
hdfs dfs -put wordcount/file02 /inputdir
hdfs dfs -ls /inputdir

hadoop jar target/hadoop-prototyp-1.0-SNAPSHOT.jar de.menzel.hadoop.WordCount hdfs://namenode:8020/inputdir hdfs://namenode:8020/outputdir