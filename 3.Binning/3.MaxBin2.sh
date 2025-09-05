#!/usr/bin/env bash 

input_contig_fasta_directory=$"INPUT_CONTIG_DIR"
bam_directory=$"BAM_DIR" 

metabat_output_directory=$"METABAT_OUT_DIR" 
maxbin2_output_directory=$"MAXBIN2_OUT_DIR"
sequence_runs_directory=$"SAMPLE_LIST"

function createDirectory(){
	local input_directory=$1
		if [ -d "${input_directory}" ] ; then  
			echo "DIR ${input_directory} exists .. skip mkdir"
		else 
			echo "Creating dir ${input_directory} .." 
			mkdir "${input_directory}"
	fi
}

for directories in ${maxbin2_output_directory}
	do 
		createDirectory "${directories}"
done 


while IFS=$'\t' read -r -a L 
	do
	input_contig_fasta=$"${input_contig_fasta_directory}/${L[0]}/scaffolds.fasta"
	output_sample_dir=$"${maxbin2_output_directory}/${L[0]}"

	# Extract read depth from BAM 
	depth_txt=$"${metabat_output_directory}/${L[0]}/read_depth/depth.txt"
	depth_forMaxbin2_txt=$"${metabat_output_directory}/${L[0]}/read_depth/depth_abundance.txt"
	
	cut -f1,3 "${depth_txt}" | tail -n+2 > "${depth_forMaxbin2_txt}"
	output_bin=$"${output_sample_dir}/other/maxbin2_bin"

	createDirectory "${output_sample_dir}"
	createDirectory "${output_sample_dir}/bin"
	createDirectory "${output_sample_dir}/other"
	rm -r ${output_sample_dir}/bin/*fasta 
	run_MaxBin.pl -contig "${input_contig_fasta}" -out "${output_bin}" -abund "${depth_forMaxbin2_txt}" -thread "${2}" -min_contig_length 1000 
	mv ${output_sample_dir}/other/*fasta  "${output_sample_dir}/bin/"
done < "${sequence_runs_directory}"/"${1}" 
