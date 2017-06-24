#!/usr/bin/env bash

hdfs dfs -rm -r /inputdir
hdfs dfs -rm -r /outputdir
hdfs dfs -mkdir /inputdir
hdfs dfs -put wordcount/inputfile /inputdir
hdfs dfs -ls /inputdir

hadoop jar target/hadoop-prototyp-1.0-SNAPSHOT.jar de.menzel.hadoop.WordCount hdfs://namenode:8020/inputdir hdfs://namenode:8020/outputdir