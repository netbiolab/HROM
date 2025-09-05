#!/usr/bin/env python
import os
import sys



AAs = []
with open('AA_list.txt', 'r') as file1:
    for line in file1:
        AAs.append(line.strip())  

file1.close() 

AAs = set(AAs) 
n = 1 
total_count = [] 
with open(sys.argv[1], 'r') as file1:
    for line in file1:
        line = line.strip().split('\t')
        if n <= 5 : 
            n += 1 
            continue 
        else: 
            if 'pseudo' not in line: 
                name = line[4]
                if name in AAs : 
                    total_count.append(name) 
file1.close()

print(sys.argv[1].replace('tsv','fna')+ '\t' + str(len(set(total_count)))) 
