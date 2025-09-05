#!/usr/bin/env python 

import sys 
name_file = "bin_stats_ext.tsv"

checkm_file = open(sys.argv[1],'r') 

checkm = checkm_file.readlines() 
checkm_file.close()
parsed_genome_output = "checkM_result.tsv"
outf = open(sys.argv[2], 'w') 
outf.write("genome_or_bin_name\tlineage\tcompleteness\tcontamination\tquality_score\tbin_quality_definition\tN50\tgenome_size\n") 

for line in checkm:
    genome_bin_name = line.strip().split('\t')[0] 
    otherline = line.strip().split('\t')[-1] 
    marker_lineage = otherline.split(',')[0].split(':')[-1].strip()
    completeness = float(otherline.split(',')[10].split(':')[-1].strip()) 
    contamination = float(otherline.split(',')[11].split(':')[-1].strip()) 
    n50 = float(otherline.split(',')[20].split(':')[-1].strip())
    genome_size = float(otherline.split(',')[14].split(':')[-1].strip())
    quality_score = completeness - 5*contamination
    if quality_score > 50 and completeness > 50 and contamination < 5 :
        if completeness >= 90 :
            outf.write(genome_bin_name + '\t' + str(marker_lineage) +'\t' + str(completeness) + '\t' + str(contamination) + '\t' + str(quality_score) + '\t' + "High_Quality_Genome" + '\t' + str(n50) + '\t' + str(genome_size) + '\n')
        else :
            outf.write(genome_bin_name + '\t' + str(marker_lineage) +'\t' + str(completeness) + '\t' + str(contamination) + '\t' + str(quality_score) + '\t' + "Medium_Quality_Genome" + '\t' + str(n50) + '\t' + str(genome_size) + '\n')
    else :
        outf.write(genome_bin_name + '\t' + str(marker_lineage) +'\t' + str(completeness) + '\t' + str(contamination) + '\t' + str(quality_score) + '\t' + "QC_failed_Genome" + '\t' + str(n50) + '\t' + str(genome_size) + '\n')


outf.close() 
