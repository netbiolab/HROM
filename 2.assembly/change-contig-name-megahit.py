#!/usr/bin/env python 
import sys 

output_file = open(sys.argv[2], 'w') 

with open(sys.argv[1],'r') as megahit: 
    for line in megahit: 
        if line.startswith(">"): 
            line = line.replace(" ","_") 
            line = line.replace("=","_") 
            output_file.write(line) 
        else: 
            output_file.write(line)

megahit.close() 
            
