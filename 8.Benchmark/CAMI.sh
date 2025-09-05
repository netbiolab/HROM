#!/usr/bin/env bash

export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1
export VECLIB_MAXIMUM_THREADS=1

#conda activate camisim

cat ${1} | while read line 
	do 
	time python tools/CAMISIM/metagenomesimulation.py 0_configs_files-ini/${line} 
done 

