#!/usr/bin/env python 
import sys 

metawrap_bin_stat_file = open(sys.argv[1], 'r')
outf = open(sys.argv[2], 'w') 

metawrap_bin_stat = metawrap_bin_stat_file.readlines() 



metawrapline2added_qualityscore = {}  
metawrap_bin_stat_header = metawrap_bin_stat[0] 

metawrap_bin_stat_header = metawrap_bin_stat_header.strip() 
metawrap_bin_stat_header += '\tUHGG_HRGM_quality_score' + '\t'+ 'bin_quality_definition\n' 
outf.write(metawrap_bin_stat_header) 

metawrap_bin_stat.pop(0) 
for line in metawrap_bin_stat:  
    line = line.strip() 
    completeness = float(line.split('\t')[1]) 
    contamination = float(line.split('\t')[2]) 
    quality_score = completeness - 5*contamination
    line2export = line 
    line2export += '\t'
    line2export += str(quality_score) 
    if quality_score > 50 and completeness >= 50 and contamination < 5 :  
        if completeness >= 90 : 
            outf.write(line2export + "\tHQ\n") 
        else :
            outf.write(line2export + "\tMQ\n") 
    else : 
        outf.write(line2export + "\tQC_failed\n") 
        

outf.close() 
