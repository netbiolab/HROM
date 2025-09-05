#!/usr/bin/env bash 


cat ${1} | while read line 
	do 
	tblastn -query all_65.markers.faa  -db genome_blastdb/${line%.fna} -outfmt 6 -evalue 1e-05 -num_threads 1 > output/${line%.fna}.tsv 
done 
