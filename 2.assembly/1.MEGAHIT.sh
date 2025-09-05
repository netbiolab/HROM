#!/usr/bin/bash 

input_seq_directory=$"INPUT_DIR"
output_assembly_directory=$"OUTPUT_DIR" 
sequence_runs_directory=$"SAMPLE_LIST_DIR" 

for directories in ${output_assembly_directory}
	do
		echo -e "Check if DIR  ${directories} exists.. "
		if [ -d "${directories}" ] ; then  
			echo "DIR ${1} exists .. skip mkdir"
		else 
			echo "Creating dir == ${directories} .." 
			mkdir "${directories}"
	fi
done 

CODE_DIR=$"CODE_DIR"
while IFS=$'\t' read -r -a L 
	do
	megahit -1 "${input_seq_directory}"/"${L[0]}"_1.fastq.gz -2  "${input_seq_directory}"/"${L[0]}"_2.fastq.gz  -o "${output_assembly_directory}"/"${L[0]}" -t "${2}" -m 0.60
	${CODE_DIR}/change-contig-name-megahit.py "${output_assembly_directory}"/"${L[0]}"/final.contigs.fa "${output_assembly_directory}"/"${L[0]}"/scaffolds.fasta 
done < "${sequence_runs_directory}"/"$1" 


