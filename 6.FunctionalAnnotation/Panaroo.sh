#!/bin/bash

cat ${1} | while read line 
	do 
	panaroo -i cluster/${line}/*gff -c 0.90 --core_threshold 0.90 -f 0.5 --clean-mode strict --merge_paralogs -o panaroo_result/${line} -t 28 
done 
