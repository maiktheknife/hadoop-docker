#!/usr/bin/env python

from os.path import join
from random import randint
from shutil import rmtree

from os import mkdir


def generate_dump(year, count=10000, min_temp=10, max_temp=40):
	file = join(output_dir, str(year))
	data = map(lambda x: str(randint(min_temp, max_temp)), range(count))
	with open(file, 'w+') as output_file:
		output_file.write(str(year) + ":")
		output_file.write(",".join(data))


output_dir = "years"
rmtree(output_dir, ignore_errors=True)
mkdir(output_dir)
for year in range(1960, 1963):
	generate_dump(year)
