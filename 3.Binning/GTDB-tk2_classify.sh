#!/usr/bin/env bash 
 
gtdbtk identify --genome_dir ${1} --out_dir GTDB/${1}/GTDB_identity --extension fna --cpus ${2} 
gtdbtk align --identify_dir GTDB/${1}/GTDB_identity --out_dir GTDB/${1}/GTDB_aligned --cpus ${2}
gtdbtk classify --genome_dir ${1} --align_dir GTDB/${1}/GTDB_aligned --out_dir GTDB/${1}/GTDB_classfication --cpus ${2} -x fna --full_tree 


