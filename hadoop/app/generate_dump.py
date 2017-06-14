#!/usr/bin/env python

with open('data.txt', 'w') as output_file:
    #data = range(0, 100_000_000)
    #data = map(lambda x: str(x), data)
    #output_file.write(",".join(data))
    output_file.write(",".join(map(lambda x: str(x), range(0, 100_000_000))))
