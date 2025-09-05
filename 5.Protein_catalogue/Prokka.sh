#!/usr/bin/env bash 

INPUT_DIR=$"INPUT_DIR"
OUT_DIR=$"OUT_DIR"

cat ${1} |while read GENOME; 
	do 
	prokka --outdir ${OUT_DIR}/${GENOME%.fna} --prefix ${GENOME%.fna} --locustag ${GENOME%.fna} --kingdom Bacteria --cpus ${2} ${INPUT_DIR}/${GENOME} 
done
