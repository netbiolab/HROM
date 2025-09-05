#!/usr/bin/env bash 

cat ${1} | while read line
	do 
	barrnap -o FASTA/${line%.fna}_rna.fna < ./0_genomes/${line} > ./GFF/${line%.fna}.gff --kingdom bac --evalue 1e-4 --threads ${2} 
	tRNAscan-SE -A --thread ${2} ./0_genomes/${line} > 3_tRNA/${line%fna}tsv 
done 
