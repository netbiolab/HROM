#!/usr/bin/env bash 

input_contig_fasta_directory=$"INPUT_CONTIG_DIR"
bam_directory=$"BAM_DIR"
metabat_output_directory=$"METABAT_OUT_DIR"
maxbin2_output_directory=$"MAXBIN2_OUT_DIR"
concoct_output_directory=$"CONCOCT_OUT_DIR"
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

for directories in ${concoct_output_directory}
	do 
		createDirectory "${directories}"
done 
CUTUP_CODE=$"merge_cutup_clustering.py"

echo -e "commencing CONCOCT" 
while IFS=$'\t' read -r -a L 
	do
	input_contig_fasta=$"${input_contig_fasta_directory}/${L[0]}/scaffolds.fasta"
	output_sample_dir=$"${concoct_output_directory}/${L[0]}"
	concoct_output_dir=$"${output_sample_dir}/concoct_output"
	concoct_bed=$"${output_sample_dir}/contigs_10K.bed"
	cut_up_contig=$"${output_sample_dir}/contigs_10K.fa"
	coverage_table=$"${output_sample_dir}/coverage_table.tsv"
	
	sorted_bam=$"${bam_directory}/${L[0]}/contig_sorted.bam" 

	createDirectory "${output_sample_dir}"

	cut_up_fasta.py "${input_contig_fasta}"  -c 10000 -o 0  --merge_last -b "${concoct_bed}"  > "${cut_up_contig}"
	concoct_coverage_table.py "${concoct_bed}" "${sorted_bam}" > "${coverage_table}" 
	concoct --composition_file "${cut_up_contig}" --coverage_file "${coverage_table}" -b "${concoct_output_dir}/" --threads "${2}"
	${CUTUP_CODE} ${concoct_bed} "${concoct_output_dir}/clustering_gt1000.csv" > "${output_sample_dir}/clustering_merged_custom.csv"

	createDirectory  "${output_sample_dir}/final_bin/"
	createDirectory  "${output_sample_dir}/final_bin_custom/"
	extract_fasta_bins.py "${input_contig_fasta}" "${output_sample_dir}/clustering_merged_custom.csv" --output_path "${output_sample_dir}/final_bin_custom/"
	
done < "${sequence_runs_directory}"/"${1}" 
