#!/bin/bash

#create HOG and OG id mapping file

awk '{print$1,$2}' ../Phylogenetic_Hierarchical_Orthogroups/N0.tsv > HOG.list

#find the OG id from HOG.list
while read -r hog; do
    grep "^$hog" HOG.list | awk '{print $2}'
done < Orthogroups_SingleCopyOrthologues.txt > single_copy_OG_ids.txt
