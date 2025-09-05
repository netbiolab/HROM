#!/usr/bin/env bash 

raw_reads_directory=$"RAW_READ_DIR"
outputs_reads_directory=$"OUTPUT_DIR" 
qc_failed_directory=$"QC_FAILED_DIR"
log_directory=$"LOG_DIR"
sequence_runs_directory=$"SAMPLE_LIST_DIR"
ADAPTER=$"ADAPTER_FILE"

for directories in ${outputs_reads_directory} ${qc_failed_directory} ${log_directory}
	do
		echo -e "Check if DIR ${1} exists under ${directories} .. "
		if [ -d "${directories}"/"${1}" ] ; then 
			echo "DIR ${1} exists .. skip mkdir"
		else 
			echo "Creating dir == ${directories}/${1} .." 
			mkdir "${directories}"/"${1}"
	fi
done 

while IFS=$'\t' read -r -a L 
	do
	echo -e "run accession is ${L[0]}"
	java -jar ~/trimmomatic-0.39/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads "$2" -phred33 "${raw_reads_directory}"/"$1"/"${L[0]}"_1.fastq.gz "${raw_reads_directory}"/"${1}"/"${L[0]}"_2.fastq.gz "${outputs_reads_directory}"/"${1}"/"${L[0]}"_1.fastq.gz "${qc_failed_directory}"/"${1}"/"${L[0]}"_1.fastq.gz "${outputs_reads_directory}"/"${1}"/"${L[0]}"_2.fastq.gz "${qc_failed_directory}"/"${1}"/"${L[0]}"_2.fastq.gz ILLUMINACLIP:${ADAPTER}:2:30:7 LEADING:5 TRAILING:5 SLIDINGWINDOW:4:5 MINLEN:36 -summary "${log_directory}"/"${1}"/"${L[0]}"_trimmomatic_summary 
		
	rm "${qc_failed_directory}"/"${1}"/"${L[0]}"_1.fastq.gz 
	rm "${qc_failed_directory}"/"${1}"/"${L[0]}"_2.fastq.gz 
done < "${sequence_runs_directory}"/"$1" 
