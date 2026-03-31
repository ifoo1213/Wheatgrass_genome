#!/bin/bash

for file in *.aln.fa
do
	iqtree2 -s "$file" -m LG -bb 1000 -nt AUTO -pre "${file%.fasta}"
done
