#!/bin/bash

#Create 10-bp windows with name and window numbers 
# For dominant genes
bedtools makewindows -b dominant_flanking.bed -w 10 -i srcwinnum > temp_dominant_windows.bed &&
#count the LTR features in the windows and keep the name in output file
bedtools intersect -a temp_dominant_windows.bed -b LTR.bed -c -wa > LTR_counts_dominant_windows.txt &&



# For suppressed genes
bedtools makewindows -b suppressed_flanking.bed -w 10 -i srcwinnum > temp_suppressed_windows.bed &&
#count the LTR features in the windows and keep the name in output file
bedtools intersect -a temp_suppressed_windows.bed -b LTR.bed -c -wa > LTR_counts_suppressed_windows.txt &&


#Compute LTR coverage


python Coverage_LTR.py