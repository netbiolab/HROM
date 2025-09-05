#!/usr/bin/env python
import os
import sys


aln_length = 0 
sim_errors = 0 


genome1_name = sys.argv[2] 
genome2_name = sys.argv[3] 
genome1_length = sys.argv[4] 
genome2_length = sys.argv[5] 


with open(sys.argv[1], 'r') as file1:
    for line in file1:
        line = line.strip().split('\t')
        aln_length += abs(int(line[1]) - int(line[0]))
        sim_errors += int(line[4])

cover1 = float(aln_length) / float(genome1_length)
cover2 = float(aln_length) / float(genome2_length)

try:
    ani = 1.0 - float(sim_errors) / aln_length
except ZeroDivisionError:
    ani = 0
cover = max([cover1, cover2])
print(genome1_name + '\t' + genome2_name + '\t' + str(ani)+'\t'+str(cover))
outf = open(sys.argv[6] ,'w') 
outf.write(genome1_name + '\t' + genome2_name + '\t' + str(ani)+'\t'+str(cover) + '\n')



outf.close() 
file1.close()
