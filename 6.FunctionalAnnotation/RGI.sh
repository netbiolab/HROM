#!/usr/bin/env bash 

cat ${1} | while read line
	do 
	rgi main --input_sequence 2_CDS_amino_acid/${line} --output_file 4_RGI/${line%.faa} --clean --num_threads ${2} --include_loose -t protein 
done 
