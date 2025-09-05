#!/usr/bin/env python
import os
import sys

genomes2coregenome = {} 
cluster2number = {} 

with open('cluster2Size.tsv','r') as file1:
    for line in file1: 
        line = line.strip().split('\t') 
        cluster2number[line[0]] = int(line[1]) 
        genomes2coregenome[line[0]] = [] 
file1.close() 


inner_ratio = {} 
with open('inner_ratio.txt','r') as file2: 
    for line in file2: 
        line = line.strip().split('\t') 
        inner_ratio[line[0]] = float(line[1]) 
file2.close() 

n = 1 
all_filtered_protein_cluster = []  
with open('initial-clustering-summary.tsv', 'r') as file1:
    for line in file1:
        if 'protein_cluster' not in line: 
            line = line.strip().split('\t')
            protein_cluster_name = line[0] 
            inner_protein_cluster_ratio = inner_ratio[protein_cluster_name]
            genome_in_list = line[1:]  
            for matchs in genome_in_list:
                matchs = matchs.split(' : ')  
                rep_cluster_name = matchs[0] 
                rep_cluster_count = int(matchs[1]) 
                rep_cluster_total_count = cluster2number[rep_cluster_name]
                coreness_threshold = 0.6
                if cluster2number[rep_cluster_name] <= 100: 
                    coreness_threshold = 0.5
                if rep_cluster_count/rep_cluster_total_count < 1.5 : 
                    if inner_protein_cluster_ratio >= coreness_threshold : 
                        genomes2coregenome[rep_cluster_name].append(protein_cluster_name)
                        all_filtered_protein_cluster.append(protein_cluster_name)
file1.close()

all_filtered_protein_cluster  = set(all_filtered_protein_cluster) 

filtered_protein_cluster2genome = {} 
for line in all_filtered_protein_cluster: 
    filtered_protein_cluster2genome[line] = []

for line in genomes2coregenome: 
    initial_marker_list = genomes2coregenome[line]
    for initial_marker in initial_marker_list: 
        filtered_protein_cluster2genome[initial_marker].append(line) 

for line in filtered_protein_cluster2genome:        
    if len(filtered_protein_cluster2genome[line]) > 10 : 
        for genome_cluster_1 in filtered_protein_cluster2genome[line]:
            genomes2coregenome[genome_cluster_1].remove(line) 

dir_1 = 'DIR'

for line in genomes2coregenome:
    filtered_marker = genomes2coregenome[line] 
    outf = open(dir_1 + line,'w') 
    for line2 in filtered_marker: 
        outf.write(line2 + '\n')
    outf.close() 
