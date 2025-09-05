#!/usr/bin/env bash 


for perc in 100 95 90 70 50 
	do 
	mmseqs createdb 0_protein_catalog_FAA/all_Protein_by_Prokka.faa mmseqs_db/DB 
	mmseqs linclust mmseqs_db/DB mmseqs_cluster_result/${perc}/DB tmp/${perc} --min-seq-id ${perc} --kmer-per-seq 80 --threads 30 --cluster-mode 2 
	mmseqs createsubdb mmseqs_cluster_result/${perc}/DB mmseqs_db/${perc}/DB mmseqs_cluster_SubDB/${perc}/DB 
	mmseqs createtsv mmseqs_db/${perc}/DB mmseqs_db/${perc}/DB mmseqs_cluster_result/${perc}/DB TSV/${perc}.tsv 
	mmseqs convert2fasta mmseqs_cluster_SubDB/${perc}/DB 0_protein_catalog_FAA/${perc}_represent.faa
done
