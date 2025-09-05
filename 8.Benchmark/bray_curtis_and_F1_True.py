#!/usr/bin/env python

import os
import sys
from scipy.spatial import distance 
from sklearn.metrics import accuracy_score, recall_score, precision_score, f1_score

answer = {} 
querie = {} 

with open('HROM_SPECIES.list','r') as file1: 
    for line in file1:
        line = line.strip().split('.fna\t') 
        answer[line[0]] = 0 
        querie[line[0]] = 0 
file1.close() 

with open(sys.argv[1], 'r') as file1:
    for line in file1:
        line = line.strip().split('.fna\t') 
        name = '_'.join(line[0].split('_')[0:3]) 
        answer[name] += float(line[1])
file1.close() 

with open(sys.argv[2],'r') as file2:
    for line in file2:
        line = line.strip().split('\t')
        querie[line[0]] = float(line[1]) 
file2.close() 

##
detection_answer = []
detection_querie = [] 

abundance_answer = [] 
abundance_querie = [] 

for line in answer:
    abundance_answer.append(answer[line]) 
    abundance_querie.append(querie[line]) 
    if answer[line] == 0:
        detection_answer.append(0) 
    elif answer[line] > 0:
        detection_answer.append(1) 
    if querie[line] == 0:
        detection_querie.append(0)
    elif querie[line] > 0:
        detection_querie.append(1)

braycurtis_sim = 1 - distance.braycurtis(abundance_answer, abundance_querie) 
braycurtis_sim = str(braycurtis_sim)

recall = str(recall_score(detection_answer, detection_querie))
accuracy = str(accuracy_score(detection_answer, detection_querie))
precision = str(precision_score(detection_answer, detection_querie))
f1_scores = str(f1_score(detection_answer, detection_querie))

answer_name = sys.argv[2].replace('.result','').replace('/','\t') 

print(answer_name + '\t' + accuracy + '\t' + recall + '\t' + precision + '\t' + f1_scores + '\t' + braycurtis_sim)






