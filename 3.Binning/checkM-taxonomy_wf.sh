#!/usr/bin/env bash 

function createDirectory(){
	local input_directory=$1
		if [ ! -d "${input_directory}" ] ; then
			mkdir "${input_directory}"
	fi
}

working_directory=$"WORK_DIR"
genome_directory=$"GENOMES_DIR"
stat_directory=$"STAT_DIR"
output_dir=$"OUTPUT_DIR"

cat ${working_directory}/${1} | grep bin_quality_definition -v | cut -f 1,6 | while IFS=$'\t' read fna clade 
	do	 
		clade_name_dir=$( echo ${clade} | sed 's/ /_/g' )
		createDirectory ${working_directory}/${clade_name_dir} 
		createDirectory ${working_directory}/${clade_name_dir}/0_genome
		createDirectory ${working_directory}/${clade_name_dir}/0_genome/1_MAGs_downloads
		createDirectory ${working_directory}/${clade_name_dir}/1_checkm_result/
		createDirectory ${working_directory}/${clade_name_dir}/1_checkm_result/1_MAGs_downloads 
		
		if [ ! -L ${working_directory}/${clade_name_dir}/0_genome/1_MAGs_downloads/${fna} ] || [ ! -e ${working_directory}/${clade_name_dir}/0_genome/1_MAGs_downloads/${fna} ]; then
			ln -s ${genome_directory}/${fna} ${working_directory}/${clade_name_dir}/0_genome/1_MAGs_downloads 
		fi 
done 

cat ${working_directory}/${1} | cut -f 6 | grep bin_quality_definition -v | sort | uniq | while read clade 
	do 
		clade_name_dir=$( echo ${clade} | sed 's/ /_/g' )
		checkm taxonomy_wf domain "Bacteria" ${working_directory}/${clade_name_dir}/0_genome/1_MAGs_downloads ${working_directory}/${clade_name_dir}/1_checkm_result/1_MAGs_downloads -t ${2} 
		${working_directory}/parse_checkM.py ${working_directory}/${clade_name_dir}/1_checkm_result/1_MAGs_downloads/storage/bin_stats_ext.tsv ${working_directory}/${clade_name_dir}/1_checkm_result/1_MAGs_downloads/storage/checkM_result.tsv
done 
