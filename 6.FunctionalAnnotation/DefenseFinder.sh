#!/bin/bash

export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1

cat ${1}| while read line 
	do 
	defense-finder run 1_proteins/${line}/${line}.faa -o 9_virus/2_defensefinder/${line} --workers 5
done 
