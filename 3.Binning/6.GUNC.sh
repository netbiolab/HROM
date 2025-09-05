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

gunc_dmnd_dir=$"GUNC_DMND_DIR/gunc_db_progenomes2.1.dmnd"

while IFS=$'\t' read -r -a L 
	do
	metawrap_output_directory=$"METAWRAP_OUT_DIR/${L[0]}"
	gunc_output_directory=$"GUNC_OUT_DIR/${L[0]}"
	createDirectory ${gunc_output_directory}
	metawrap_bin=$"${metawrap_output_directory}/${L[1]}/metawrap_51_6_bins"
	gunc_sample_out_dir=$"${gunc_output_directory}/${L[1]}"

	createDirectory "${gunc_sample_out_dir}"
	gunc run --input_dir "${metawrap_bin}" --db_file  "${gunc_dmnd_dir}" --out_dir "${gunc_sample_out_dir}"  --threads "${2}"
	
	metawrap_output_table=$"${metawrap_output_directory}/${L[1]}/metawrap_51_6_bins_stats.w.quality_score"
	gunc_output_table=$"${gunc_sample_out_dir}/GUNC.progenomes_2.1.maxCSS_level.tsv"
	
	createDirectory "${gunc_sample_out_dir}/final_bin"
	createDirectory "${gunc_sample_out_dir}/final_bin/HQ"
	createDirectory "${gunc_sample_out_dir}/final_bin/MQ"
	
	for true_HQ_output in $(cat ${gunc_sample_out_dir}/final_bin/selected_final_table.tsv | grep True | grep HQ | cut -f 1 )
		do	
			ln -s "${metawrap_bin}/${true_HQ_output}.fa" "${gunc_sample_out_dir}/final_bin/HQ"
	done 
	for true_MQ_output in $(cat ${gunc_sample_out_dir}/final_bin/selected_final_table.tsv | grep True | grep MQ | cut -f 1 )
		do	
			ln -s "${metawrap_bin}/${true_MQ_output}.fa" "${gunc_sample_out_dir}/final_bin/MQ"
	done 

done < "${1}" 
