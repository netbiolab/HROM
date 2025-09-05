#!/usr/bin/env python
import os
import sys


rna_5s = 0 
rna_16s = 0 
rna_23s = 0 

with open(sys.argv[1], 'r') as file1:
    for line in file1:
        if 'gff-version' not in line: 
            line = line.strip().split('\t') 
            name = line[8] 
            e_value = float(line[5])
            if '5S_rRNA' in name and e_value <= 1e-4: 
                rna_5s = 1
            elif '23S_rRNA' in name and e_value <= 1e-5: 
                rna_23s = 1 
            elif '16S_rRNA' in name and e_value <= 1e-5: 
                rna_16s = 1 
            
print(sys.argv[1].replace('gff','fna') + '\t' + str(rna_5s) + '\t' + str(rna_16s) + '\t' + str(rna_23s) )             

            
file1.close()
