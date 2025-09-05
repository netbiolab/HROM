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

cat ${1} | while IFS=$'\t' read comp sets sample 
	do 
	output_dir=$( echo -e "2_output/${comp}/${sets}/${sample}")

	createDirectory ${output_dir}/temp_files/ 
	createDirectory ${output_dir}/results
	metaphlan ${output_dir}/reads/anonymous_reads.fq.gz --input_type fastq --nproc ${2} --bowtie2db Source/DB/Traditional_HROM_markers/ --index HROM > ${output_dir}/temp_files/metaphlan4.txt 
	./code/summarize-mph4.py ${output_dir}/temp_files/metaphlan4.txt > ${output_dir}/results/metaphlan4.tsv 

	kraken2 --use-names --threads ${2} --db Source/DB/HQ_NC_kraken2_db/ --paired ${output_dir}/reads/anonymous_reads_1.fastq ${output_dir}/reads/anonymous_reads_2.fastq --report ${output_dir}/temp_files/kraken2_Rep.report --output ${output_dir}/results/kraken2_Rep.output --confidence 0.2 
	rm ${output_dir}/results/kraken2_Rep.output 
	./tools/Bracken/bracken -d Source/DB/HQ_NC_kraken2_db/ -i ${output_dir}/temp_files/kraken2_Rep.report -o ${output_dir}/temp_files/kraken2_Rep.bracken -l 'S' -r 150
	./code/summarize-bracken.sh ${output_dir}/temp_files/kraken2_Rep_bracken_species.report > ${output_dir}/temp_files/kraken2_Rep.before.norm 
	./code/normalize-genomesize.py ${output_dir}/temp_files/kraken2_Rep.before.norm Source/representative2length.tsv > ${output_dir}/results/kraken2_Rep.tsv 

	kraken2 --use-names --threads ${2} --db Source/DB/HQ_NC_kraken2_Concat_db/ --paired ${output_dir}/reads/anonymous_reads_1.fastq ${output_dir}/reads/anonymous_reads_2.fastq --report ${output_dir}/temp_files/kraken2_Concat.report --output ${output_dir}/results/kraken2_Concat.output --confidence 0.2 
	rm ${output_dir}/results/kraken2_Concat.output 
	./tools/Bracken/bracken -d Source/DB/HQ_NC_kraken2_Concat_db/ -i ${output_dir}/temp_files/kraken2_Concat.report -o ${output_dir}/temp_files/kraken2_Concat.bracken -l 'S' -r 150
	./code/summarize-bracken.sh ${output_dir}/temp_files/kraken2_Concat_bracken_species.report > ${output_dir}/temp_files/kraken2_Concat.before.norm 
	./code/normalize-genomesize.py ${output_dir}/temp_files/kraken2_Concat.before.norm Source/concat-representative2length.tsv > ${output_dir}/results/kraken2_Concat.tsv 

done 


