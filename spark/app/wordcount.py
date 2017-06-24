#!/usr/bin/env python

import sys

from pyspark import SparkContext, SparkConf

if __name__ == "__main__":

	# create Spark context with Spark configuration
	conf = SparkConf().setAppName("Spark Count")
	sc = SparkContext(conf=conf)

	# read in text file and split each document into words
	words = sc.textFile(sys.argv[1]) \
		.flatMap(lambda line: line.split(" ")) \
		.map(lambda word: (word, 1)) \
		.reduceByKey(lambda v1, v2: v1 + v2) \
		.collect()

	print repr(words)[1:-1]