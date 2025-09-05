#!/usr/bin/env bash 


checkm analyze cpr_43_markers.hmm genome_Patescibacteria  p__Patescibacteria_checkm  -t ${1} -x fna 
checkm qa cpr_43_markers.hmm p__Patescibacteria_checkm -t ${1}
