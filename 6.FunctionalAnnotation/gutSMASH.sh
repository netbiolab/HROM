#!/bin/bash

input_dir=$"INPUT_DIR"

cat THROW | while read line 
	do 
	python3 ./gutsmash/run_gutsmash.py ${input_dir}/${line}/${line}.gbk --enable-genefunctions --genefinding-gff3 ${input_dir}/${line}/${line}.gff --cb-general --cb-knownclusters --asf --pfam2go --smcog-trees --cf-create-clusters --cpus 2 --output-dir 2_gutSMASH/${line} 
done 
