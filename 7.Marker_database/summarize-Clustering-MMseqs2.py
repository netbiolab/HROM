#!/usr/bin/env python
import os
import sys


cluster2 = {} 
with open('mmseqs2-cluster.tsv', 'r') as file1:
    for line in file1:
        line = line.strip().split('\t')
        protein_cluster = line[0] 
        genome = line[1] 
        cluster2[protein_cluster] = []
file1.close()

genomes2 = []
with open('mmseqs2-cluster.tsv', 'r') as file1:
    for line in file1:
        line = line.strip().split('\t')
        protein_cluster = line[0] 
        species_cluster = line[1] 
        cluster2[protein_cluster].append(species_cluster)
        genomes2.append(protein_cluster)
file1.close()

genomes2 = set(genomes2) 
outf2 = open('initial-clustering-summary.tsv' ,'w') 

for line in genomes2:
    clusterss = cluster2[line] 
    clusterssout = list(map(lambda n: n + " : " + str(clusterss.count(n)), clusterss))
    clusterssout.sort() 
    clusterssout = set(clusterssout) 
    outf2.write(line + '\t' + '\t'.join(clusterssout) + '\n')
outf2.close() 
