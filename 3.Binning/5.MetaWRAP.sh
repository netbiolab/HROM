#!/usr/bin/env bash 

function createDirectory(){
	local input_directory=$1
		if [ -d "${input_directory}" ] ; then 
			echo "DIR ${input_directory} exists .. skip mkdir"
		else 
			echo "Creating dir ${input_directory} .." 
			mkdir "${input_directory}"
	fi
}

while IFS=$'\t' read -r -a L 
	do
	metabat_output_directory=$"METABAT_OUT_DIR"
	maxbin2_output_directory=$"MAXBIN2_OUT_DIR"
	concoct_output_directory=$"CONCOCT_OUT_DIR"
	metawrap_output_directory=$"METAWRAP_OUT_DIR"

	createDirectory "${metawrap_output_directory}"

	concoct_sample_dir=$"${concoct_output_directory}/${L[1]}/final_bin_custom"
	metabat_sample_dir=$"${metabat_output_directory}/${L[1]}/bin"
	maxbin2_sample_dir=$"${maxbin2_output_directory}/${L[1]}/bin"

	metawrap_sample_out_dir=$"${metawrap_output_directory}/${L[1]}"

	createDirectory "${metawrap_sample_out_dir}"
	metawrap bin_refinement -o "${metawrap_sample_out_dir}" -t "${2}" -A "${metabat_sample_dir}" -B "${maxbin2_sample_dir}" -C "${concoct_sample_dir}" -c 50 -m 40 -x 6 
	mv ${metawrap_sample_out_dir}/metawrap_50_6_bins.stats ${metawrap_sample_out_dir}/metawrap_51_6_bins.stats
	mv ${metawrap_sample_out_dir}/metawrap_50_6_bins ${metawrap_sample_out_dir}/metawrap_51_6_bins
	
	./define_quality.py "${metawrap_sample_out_dir}/metawrap_51_6_bins.stats" "${metawrap_sample_out_dir}/metawrap_51_6_bins_stats.w.quality_score" 
done < ${1}
