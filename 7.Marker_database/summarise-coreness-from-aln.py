#!/usr/bin/env python
import os
import sys

		
dir_1 = '/BiO/scratch/users/k202203/TMP/non_redundant_genome/nucleic_acid_new_header/'

genelist = []
with open(dir_1 + sys.argv[1] + '.list', 'r') as file1:
	for line in file1:
		genelist.append(line.strip()) 
file1.close()
dir2 = 'DIR_1/'
dir3 = 'DIR_2/'
dir4 = 'DIR_3/'
TRUE_POS = open(dir3 + sys.argv[1] + '.list', 'w')
FAIL_LOG = open(dir4 + sys.argv[1] + '.log', 'w') 
FAIL_LOG2 = open(dir4 + sys.argv[1] + '.stats', 'w') 
FAIL_LOG3 = open(dir4 + sys.argv[1] + '.fail_sum.log', 'w') 

n = 0
total_n = len(genelist) 
for gene in genelist:
	contam = 'FALSE'
	coreness = 'FALSE'
	for_record_coreness = ''
	for_record_uniqness = ''
	contam_by_multi_clade = 'not-contam_by_multi_clade'
	with open(dir2 + gene + '.list' ,'r') as file2:
		for line in file2:
			line = line.strip().split('\t') 
			SGB = line[0] 
			perc = float(line[3])*100
			if SGB != sys.argv[1]: 
				if perc >= 1 : 
					contam = 'TRUE'
					FAIL_LOG.write(gene + '\t'+ sys.argv[1] + '\t' + '\t'.join(line) + '\t' + 'contaminated' + '\n') 
				else: 
					for_record_uniqness += SGB + ' : ' + line[-1] + ','
			elif SGB == sys.argv[1]:
				if perc >= 50: 
					coreness = 'TRUE' 
					for_record_coreness = line[-1]
				else: 
					FAIL_LOG.write(gene + '\t' +sys.argv[1] + '\t' +  '\t'.join(line) + '\t' + 'lack_coreness' + '\n') 
	if coreness == 'TRUE' and contam == 'FALSE':
		n += 1 
		TRUE_POS.write(gene + '\t' + for_record_coreness + '\t' + for_record_uniqness + '\n') 
	else: 
		FAIL_LOG3.write(gene + '\t' + coreness.replace('FALSE','lack_coreness') + '\t' + contam.replace('TRUE','contaminated') + '\n') 

TRUE_POS.close()
FAIL_LOG.close() 
FAIL_LOG2.write(str(total_n) + '\t' + str(total_n - n) + '\t' + str(n) + '\n')
FAIL_LOG2.close() 
FAIL_LOG3.close() 

