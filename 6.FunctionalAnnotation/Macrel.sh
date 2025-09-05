#!/bin/bash

cat ${1} | while read line 
	do
	time macrel peptides --fasta 5_smORF_c_AMP/1_filter_from_prodigal-OG/${line}-smORF.faa.gz --output 2_macrel/${line} --threads 2
done 
