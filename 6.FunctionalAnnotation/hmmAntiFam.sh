#!/bin/bash

cat ${1} | while read line 
	do 
	hmmsearch --cut_ga --cpu 1 --tblout 1_remove_antifam/0_hits/${line}.tsv ./AntiFam.hmm 0_pyrodigal/${line}.smORF.faa
	cat 1_remove_antifam/0_hits/${line}.tsv | grep $'#' -v | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g' | sed 's/ /\t/g' | cut -f 1 | sort | uniq > 1_remove_antifam/0_hits/${line}.hits 
	./summarize-Antifam.py ${line} 
done 


