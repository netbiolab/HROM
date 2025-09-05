#!/usr/bin/env bash 


cat ${1} | grep $'\tS\t' | cut -f 2,6 | sed 's/HROM_Genome_/\t/g' | cut -f 1,3 | sed 's/.fna//g' | while IFS=$'\t' read count number
	do 
	echo -e "HROM_Genome_${number}\t${count}" 
done 

