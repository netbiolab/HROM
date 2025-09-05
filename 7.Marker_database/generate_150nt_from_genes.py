#!/usr/bin/env python
import os
import sys
import math 


now_header = ''
header2seq = {} 
gene_length = {} 
with open(sys.argv[1], 'r') as file1:
    for line in file1:
        line = line.strip()
        if line.startswith('>'): 
            now_header = line.replace('>','')
            continue 
        else: 
            header2seq[now_header] = line 
            gene_length[now_header] = len(line) 
file1.close()

outf = open('short_read.fasta','w')
for gene_name in header2seq: 
    length_of_gene = gene_length[gene_name]    
    iteration_max = math.trunc(length_of_gene/150) 
    answer = header2seq[gene_name] 
    for n in range(0,iteration_max+ 1): 
        header = "@" + gene_name + "_iteration_number_" + str(n)   
        random_split = header2seq[gene_name][n*150:(n + 1)*150]
        if len(random_split) < 150: 
            random_split = header2seq[gene_name][-150:]
        seperator = "+" + gene_name + "_separator_" + str(n) 
        quality_phred = "H"*len(random_split)
        fastq_one_line = [header, random_split, seperator, quality_phred]
        fastq_one_line = '\n'.join(fastq_one_line) 
        outf.write(fastq_one_line + '\n') 
outf.close() 
