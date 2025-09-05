#!/usr/bin/env python 

import sys 

name = sys.argv[1] 
otu_file = open(name , 'r')
otu = otu_file.readlines()

genome_length_file = open(sys.argv[2],'r') 
genome_length = genome_length_file.readlines()

genome2length = {}
for line in  genome_length:
    genome2length[line.strip().split('\t')[0].replace('.fna','')] = float(line.strip().split('\t')[1])

otu_abs_result = {} 
og_otu_abs_result = {} 

sum_count = 0
for line in otu: 
    taxa_name = line.strip().split('\t')[0]
    input_name = taxa_name
    if input_name in list(genome2length.keys()) : 
        og = line.strip().split('\t')[1] 
        numbers =  list(map(lambda i : str((float(i)/genome2length[input_name])*1000000), line.strip().split('\t')[1:]))
        lineoutput = input_name + '\t' + '\t'.join(numbers)
        otu_abs_result[input_name] = numbers[0] 
        sum_count += float(numbers[0]) 
otu_file.close()

otu_rel_result = {} 
og_otu_rel_result = {} 

for line in otu_abs_result :
    otu_rel_result[line] =  float(otu_abs_result[line])/sum_count
    print(line + '\t' + str(otu_rel_result[line]))
