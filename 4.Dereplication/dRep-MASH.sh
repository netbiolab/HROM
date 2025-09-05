#!/usr/bin/bash


function createDirectory(){
	local input_directory=$1
		if [ -d "${input_directory}" ] ; then 
			echo "DIR ${input_directory} exists .. skip mkdir"
		else 
			echo "Creating dir ${input_directory} .." 
			mkdir "${input_directory}"
	fi
}

cat ${1} | while read line 
	do
	dRep compare --S_algorithm ANImf 2_mash/${line} -g 0_genome/${line}/*fna --MASH_sketch 10000 --P_ani 0.8 --processors 38 --SkipSecondary 
done 
