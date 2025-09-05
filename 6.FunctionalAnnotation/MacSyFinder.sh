#!/bin/bash

cat ${1} | while read line 
	do
	macsyfinder --sequence-db 1_proteins/${line}/${line}.faa -o 4_TXXSCAN/${line} --models TXSScan all --db-type ordered_replicon -w 1 --models-dir ./macsyfinder/MODELs/TXSScan-models
done 
