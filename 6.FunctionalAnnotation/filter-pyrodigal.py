#!/usr/bin/env python
import os
import sys


name2seq = {} 
new_header = '' 
with open('./0_pyrodigal/' + sys.argv[1] + '.faa','r' ) as file1:
	for line in file1:
		line = line.strip() 
		if line.startswith('>'):
			new_header = line.replace('>','')
			name2seq[new_header] = [] 
		else: 
			name2seq[new_header].append(line) 
file1.close()

n = 1 
outf = open('./0_pyrodigal/' + sys.argv[1] + '.smORF.faa','w' ) 
for headers in name2seq:  
	sequence = ''.join(name2seq[headers]).replace('*','') 
	sequence_length = len(sequence) 
	new_header_for_me = sys.argv[1] + '|smORF|' + str(n)	  
	if sequence_length >= 15 and sequence_length < 101: 
		outf.write('>' + new_header_for_me + '\n') 
		outf.write(sequence + '\n') 
		n += 1

outf.close() 
		
 


