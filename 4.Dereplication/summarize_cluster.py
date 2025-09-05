#!/usr/bin/env python
import os
import sys
import re 
import math 

dir_1 = 'CLUSTER_DIR'
dir_2 = 'CLUSTER_DIR2'
dir_3 = 'CLUSTER_DIR3'

cluster = sys.argv[1] 

genome_in_cluster = [] 
secondary_cluster = {}
with open(dir_2 + cluster, 'r') as file1:
    for line in file1:
        line = line.strip().split('\t') 
        if line[1] not in list(secondary_cluster.keys()):
            secondary_cluster[line[1]] = []
        secondary_cluster[line[1]].append(line[0])
        genome_in_cluster.append(line[0])
file1.close()


genome_intactness_score = {} 
with open('METADATA_FILE','r') as meta: 
    for metaline in meta:
        if 'bin_name' in metaline: 
            continue
        metaline = metaline.strip().split('\t') 
        genome_name = metaline[0]
        completeness = float(metaline[1]) 
        contamination = float(metaline[2]) 
        N50 = float(metaline[3])
        S = completeness - (5*contamination) + (0.5*math.log10(N50))
        genome_intactness_score[genome_name] = S 
meta.close() 

genome_stat = {}     
with open('GENOME_STAT_FILE','r') as meta1: 
    for line in meta1: 
        line = line.strip().split('\t') 
        genome_stat[line[0]] = line[8]
meta1.close()


outf1 = open('OUTPUT_DIR/' + cluster,'w')           
outf2 = open('OUTPUT_DIR/' + cluster,'w')           
    
n = 0    
for line in secondary_cluster : 
    outputs = ';'.join(secondary_cluster[line])
    secondary_cluster[line] = outputs
genome_in_cluster = list(secondary_cluster.values())
save_for_2nd_output = {} 
save_for_2nd_output_max_genome = {} 
for line in genome_in_cluster: 
    line = line.split(';') 
    temp_cluster = {} 
    for genome in line:
        temp_cluster[genome] = genome_intactness_score[genome] 
    max_genome = max(temp_cluster, key = temp_cluster.get)
    outf1.write('secondary_cluster_' + str(n) + '\t' + max_genome + '\t' + str(len(line)) + '\t' +';'.join(line) + '\n')
    save_for_2nd_output['secondary_cluster_' + str(n)] = line 
    save_for_2nd_output_max_genome['secondary_cluster_' + str(n)] = max_genome
    n += 1

for sc in save_for_2nd_output: 
    for genome_in in save_for_2nd_output[sc]:
            outf2.write(sc + '\t' + save_for_2nd_output_max_genome[sc] + '\t' + genome_in + '\t' +  genome_stat[save_for_2nd_output_max_genome[sc]] + ' : ' + genome_stat[genome_in] + '\n' ) 


outf1.close() 
outf2.close()  
