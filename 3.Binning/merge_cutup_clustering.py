#!/usr/bin/env python

import sys, operator

bed_filename = sys.argv[1]
cluster_filename = sys.argv[2]

fragment2original = dict()
with open(bed_filename) as bedf:
	for line in bedf:
		line = line.strip()
		(original,a,b,frag) = line.split("\t")
		fragment2original[frag] = original

original_bin2count = dict()
header= True
with open(cluster_filename) as clusterf:
	for line in clusterf:
		line = line.strip()
		if header:
			header = False
			print (line)
			continue
		frag, cluster = line.split(",")
		original = fragment2original[frag]

		if original not in original_bin2count:
			original_bin2count[original] = dict()
		if cluster not in original_bin2count[original]:
			original_bin2count[original][cluster] = 0
		original_bin2count[original][cluster] += 1

for original in original_bin2count:
	sorted_cluster2count = sorted(original_bin2count[original].items(), key=operator.itemgetter(1), reverse=True)
	try:
		if sorted_cluster2count[0][1] == sorted_cluster2count[1][1]:
			continue
		print (original+','+sorted_cluster2count[0][0])
	except:
		print (original+','+sorted_cluster2count[0][0])
