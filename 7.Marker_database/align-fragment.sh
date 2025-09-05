#!/bin/bash 

cat ${1} | while IFS=$'\t' read cluster genome
	 do 
	genome_index=$"./bowtie2_DB_per_species/${cluster}/DB/${genome%.fna}/DB"
	input_fastq=$"./short_read.fastq"
	input_fasta=$"./short_read.fasta"
	outdir=$"./ALIGN_LOG/"
	samdir=$"./ALIGN_SAM/"
	(time bowtie2 -p 4 -a --very-sensitive --no-unal --no-sq -x "${genome_index}" -f ${input_fasta} -S ${samdir}/${cluster}_${genome}.sam  ) 2> ${outdir}/${cluster}__${genome}.log
done

