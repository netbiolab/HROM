#!/usr/bin/env python
import os
import sys


name2seq = {} 
new_header = '' 
with open('./0_pyrodigal/' + sys.argv[1] + '.smORF.faa','r' ) as file1:
	for line in file1:
		line = line.strip() 
		if line.startswith('>'):
			new_header = line.replace('>','')
		else: 
			name2seq[new_header] = line 
file1.close()

hits = [] 
with open('1_remove_antifam/0_hits/' + sys.argv[1] + '.hits','r') as file1:
	for line in file1:
		hits.append(line.strip())
file1.close() 

hits = set(hits) 
outf = open('./1_remove_antifam/1_tsv/' + sys.argv[1] + '.smORF.tsv','w' ) 
for header in name2seq:
	if header not in hits: 
		outf.write(header + '\t' + name2seq[header] + '\n') 
outf.close() 
		
 


