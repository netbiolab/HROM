#!/bin/bash

cat ${1} | while read line 
	do
	anvi-script-reformat-fasta new_header/${line} --simplify-names -o new_header_anvio/${line}  --seq-type NT 
	anvi-gen-contigs-database -f new_header_anvio/${line} -o ANVIO_DB/${line%fna}db 
	anvi-run-kegg-kofams -c ANVIO_DB/${line%fna}db -T 4
	anvi-estimate-metabolism -c ANVIO_DB/${line%fna}db -O ANVIO_module_Completeness/${line%fna}module.tsv

done 
