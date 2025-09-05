#!/usr/bin/env python 
import sys

input_file = sys.argv[1]

with open(input_file, 'r') as f:
    for line in f:
        if 't__' not in line:
            continue
        fields = line.strip().split('\t')
        if len(fields) < 3:
            continue

        f1, f3 = fields[0], fields[2]

        split_parts = f1.replace("t__", "\t").split('\t')
        if len(split_parts) < 2:
            continue
        count = split_parts[1]
        try:
            number = float(f3)
            abun = number / 100
        except ValueError:
            continue

        print(f"{count}\t{abun}")

