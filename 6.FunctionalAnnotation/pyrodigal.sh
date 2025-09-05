#!/bin/bash

cat ${1} | while read line 
	do
	pyrodigal -i non_red_genome/${line}.fna -a 0_pyrodigal/${line}.faa --min-gene 33 --min-edge-gene 33 --max-overlap 33
	./filter-pyrodigal.py ${line} 
done 
