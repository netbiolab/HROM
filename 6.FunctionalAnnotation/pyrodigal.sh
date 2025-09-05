#!/bin/bash
#$ -N pyodigal-THROW
#$ -q kobic.q 
#$ -e /BiO/scratch/users/k202302/TMP/AMP/error_directory 
#$ -o /BiO/scratch/users/k202302/TMP/AMP/error_directory 
#$
#$ -pe pe_slots 1

source ~/.bashrc

conda activate macrel 

cd /BiO/scratch/users/k202302/TMP/AMP 

cat THROW | while read line 
	do
	pyrodigal -i non_red_genome/${line}.fna -a 0_pyrodigal/${line}.faa --min-gene 33 --min-edge-gene 33 --max-overlap 33
	./filter-pyrodigal.py ${line} 
	rm 0_pyrodigal/${line}.faa 
done 
