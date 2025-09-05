#!/usr/bin/env bash 

input_contig_fasta_directory=$"INPUT_ASSEMBLY_DIR"
bowtie2_db_directory=$"BOWTIE2_DB_DIR"
bowtie2_output_directory=$"BOWTIE2_OUTPUT_DIR" 
sample_QC_reads_directory=$"QC_READS_DIR"

echo -e "The working Project is .. Bioproject=${1}" 

sequence_runs_directory=$"SAMPLE_LIST_DIR"

function createDirectory(){
	local input_directory=$1
		if [ -d "${input_directory}" ] ; then  
			echo "DIR ${input_directory} exists .. skip mkdir"
		else 
			echo "Creating dir ${input_directory} .." 
			mkdir "${input_directory}"
	fi
}

for directories in ${bowtie2_db_directory} ${bowtie2_output_directory} 
	do 
		createDirectory "${directories}"
done 

echo -e "commencing bowtie2-build" 

while IFS=$'\t' read -r -a L 
	do
	input_contig_fasta=$"${input_contig_fasta_directory}/${L[0]}/scaffolds.fasta"
	output_contig_index_dir=$"${bowtie2_db_directory}/${L[0]}"
	createDirectory "${output_contig_index_dir}"
	output_contig_index=$"${bowtie2_db_directory}/${L[0]}/contigs"
	
	bowtie2-build -f "${input_contig_fasta}"  "${output_contig_index}" --threads "${2}"
	
	output_alignment_dir=$"${bowtie2_output_directory}/${L[0]}"
	createDirectory "${output_alignment_dir}"
	
	sample_fwd_read_gz=$"${sample_QC_reads_directory}/${L[0]}_1.fastq.gz"
	sample_rvs_read_gz=$"${sample_QC_reads_directory}/${L[0]}_2.fastq.gz"
	sample_aligned_sam=$"${output_alignment_dir}/contig_aligned.sam"
	bowtie_log=$"${output_alignment_dir}/log"
	contig_sorted_bam=$"${output_alignment_dir}/contig_sorted.bam"
	
	(bowtie2 -p "${2}" -x "${output_contig_index}" -1 "${sample_fwd_read_gz}" -2 "${sample_rvs_read_gz}" -S "${sample_aligned_sam}" --very-sensitive-local ) 2> "${bowtie_log}"
	samtools sort -l 5 -o "${contig_sorted_bam}" -@ "${2}" "${sample_aligned_sam}"		
	samtools index  "${contig_sorted_bam}" -@ "${2}" 		
done < "${sequence_runs_directory}"/"${1}" 
