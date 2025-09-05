#!/usr/bin/env bash 

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

echo -e "commencing MetaBAT2" 

while IFS=$'\t' read -r -a L 
	do
	input_contig_fasta_directory=$"ASSEMBLY_DIR/${L[0]}" 
	bam_directory=$"BAM_FILE_DIR/${L[0]}" 
	metabat_output_directory=$"METABAT_OUT_DIR/${L[0]}"
	createDirectory ${metabat_output_directory} 
	input_contig_fasta=$"${input_contig_fasta_directory}/${L[1]}/scaffolds.fasta"
	echo "${input_contig_fasta}"
	
	output_sample_dir=$"${metabat_output_directory}/${L[1]}"
	createDirectory "${output_sample_dir}"
	input_sorted_bam=$"${bam_directory}/${L[1]}/contig_sorted.bam"
	depth_dir=$"${output_sample_dir}/read_depth"
	bin_dir=$"${output_sample_dir}/bin"
	createDirectory "${depth_dir}" 
	createDirectory "${bin_dir}" 

	depth_txt=$"${depth_dir}/depth.txt"
	output_bin=$"${bin_dir}/metabat2_bin"
	jgi_summarize_bam_contig_depths --outputDepth "${depth_txt}" "${input_sorted_bam}" --minContigLength 1000 --minContigDepth 1
	metabat2 -i "${input_contig_fasta}" -a "${depth_txt}" -o "${output_bin}" -t "${2}" --minContig 1500 
done < "${1}" 
