#!/usr/bin/env bash 

trimmed_reads_directory=$"TRIM_READ_DIR"
outputs_reads_directory=$"OUTPUT_DIR"

aligned_to_human_directory=$"ALN_HUM_DIR" 
logs_directory=$"LOG_DIR" 
sequence_runs_directory=$"SAMPLE_LIST_DIR"

for directories in ${outputs_reads_directory} ${aligned_to_human_directory} ${logs_directory}
	do
		echo -e "Check if DIR  ${1} exists under ${directories} .. "
		if [ -d "${directories}"/"${1}" ] ; then  
			echo "DIR ${1} exists .. skip mkdir"
		else 
			echo "Creating dir == ${directories}/${1} .." 
			mkdir "${directories}"/"${1}"
	fi
done 

GRCH38_DIR=$"GRCH38_FILE_DIR"

while IFS=$'\t' read -r -a L 
	do
	(bowtie2 -p "${2}"  -x ${GRCH38_DIR}  -1 "${trimmed_reads_directory}"/"${1}"/"${L[0]}"_1.fastq.gz  -2 "${trimmed_reads_directory}"/"${1}"/"${L[0]}"_2.fastq.gz -S "${aligned_to_human_directory}"/"${1}"/"${L[0]}".bowtie.sam --very-sensitive) 2> "${logs_directory}"/"${1}"/"${L[0]}"_bowtie_log   
	samtools view -u -f 12 -F 256 "${aligned_to_human_directory}"/"${1}"/"${L[0]}".bowtie.sam -@ "${2}"  > "${outputs_reads_directory}"/"${1}"/"${L[0]}"_unmapped.bam
	samtools fastq "${outputs_reads_directory}"/"${1}"/"${L[0]}"_unmapped.bam -1 "${outputs_reads_directory}"/"${1}"/"${L[0]}"_1.fastq.gz -2 "${outputs_reads_directory}"/"${1}"/"${L[0]}"_2.fastq.gz  -@  "${2}" -O -0 "${outputs_reads_directory}"/"${1}"/"${L[0]}"_0.fastq.gz
	
done < "${sequence_runs_directory}"/"$1" 

