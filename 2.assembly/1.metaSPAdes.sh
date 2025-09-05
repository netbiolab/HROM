#!/usr/bin/bash 

input_seq_directory=$"INPUT_READS_DIR"
output_assembly_directory=$"OUTPUT_DIR"

echo -e "The working Project is .. Bioproject=${1}" 

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

while IFS=$'\t' read -r -a L 
	do
	metaspades.py -1 "${input_seq_directory}"/"${L[0]}"_1.fastq.gz -2 "${input_seq_directory}"/"${L[0]}"_2.fastq.gz -o "${output_assembly_directory}"/"${L[0]}" -t "${2}" --memory 350
done < "${sequence_runs_directory}"/"$1" 
