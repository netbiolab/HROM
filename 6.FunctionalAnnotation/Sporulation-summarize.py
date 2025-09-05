#!/usr/bin/env python
import os
import sys


true_positive = [] 
with open('output/' + sys.argv[1] + '.tsv', 'r') as file1:
    for line in file1:
        line = line.strip().split('\t')
        marker_name = line[0] 
        perc_identity = float(line[2]) 
        evalue = float(line[10]) 
        if perc_identity >= 30 and evalue <= 1e+5:
            true_positive.append(marker_name) 
file1.close()
true_positive = set(true_positive) 
print('_'.join(sys.argv[1].split('_')[0:3]) + '\t' + sys.argv[1] + '\t' + str(len(true_positive)))
