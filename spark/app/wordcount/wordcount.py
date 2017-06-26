#!/usr/bin/env python

import sys
import re

from pyspark import SparkContext, SparkConf

if __name__ == "__main__":

	# create Spark context with Spark configuration
	conf = SparkConf().setAppName("Spark Count")
	sc = SparkContext(conf=conf)

	input_file = sys.argv[1]
	output_file = sys.argv[2]

	# read in text file and split each document into words
	words = sc.textFile(sys.argv[1]) \
		.flatMap(lambda line: line.split(" ")) \
		.map(lambda word: (word, 1)) \
		.reduceByKey(lambda v1, v2: v1 + v2) \
		.collect()

	# words = sc.textFile(input_file) \
	# 	.flatMap(lambda line: re.split("[ ,;.:\-!?\t\n]+", line)) \
	# 	.map(lambda word: word.strip()) \
	# 	.filter(lambda word: True if word else False) \
	# 	.map(lambda word: (word, 1))
	# print words
	#
	# x = words.reduceByKey(lambda v1, v2: v1 + v2)
	# print x
	#
	# y = x.collect()
	# print y
	#
	print repr(words)[1:-1]
	# words.saveAsTextFile(output_file)