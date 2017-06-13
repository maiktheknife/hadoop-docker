#!/usr/bin/env bash
hadoop jar target/hadoop-prototyp-1.0-SNAPSHOT.jar de.menzel.hadoop.WordCount hdfs://namenode:8020/inputdir hdfs://namenode:8020/outputdir