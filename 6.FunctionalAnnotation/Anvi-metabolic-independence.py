#!/usr/bin/env python 

import sys 
import os

hmi_module = [] 
hmi_module_score = {} 
with open('33_Module.list','r') as file1:
	for line in file1:
		line = line.strip()
		hmi_module.append(line) 	
		hmi_module_score[line] = 0 
file1.close() 

hmi_module = set(hmi_module) 

with open('ANVIO_module_Completeness/' + sys.argv[1].replace('.fna','') + '.module.tsv_modules.txt','r') as file1:
	for line in file1:
		line = line.strip().split('\t') 
		if line[0] != 'unique_id':
			module = line[2]
			score = float(line[8])
			if module in hmi_module:
				hmi_module_score[module] = float(line[8])
file1.close() 

print('_'.join(sys.argv[1].split('_')[0:3]) + '\t' + sys.argv[1] + '\t' + str(len(hmi_module_score)) + '\t' + str(sum(hmi_module_score.values()))) 
