#Step1: Normalization of relative expression levels of the H, St1, and St2 subgenomes
#bash
# awk '{if(($4+$5+$6) >=0.5) print $1"_"$2"_"$3, $4/($4+$5+$6), $5/($4+$5+$6), $6/($4+$5+$6)}' Flower_homologous_expression.tsv > Flower_homologous_expression_normalized.tsv

#Step2: Definition of homoeologous expression bias categories for Normalization of relative expression
#R version 4.4.2
data=read.csv("Normalized_TPM_all_tissue.txt",header=F, sep="\t",row.names = 1)
dist=as.matrix(dist(data[,1:3],method = "euclidean"))[,1:7]
write.table(t(dist),file="dist.csv", quote=F)


#Step3: Identify the number of genes, check the gene number first
#bash combine all the normalized TPM data
for i in {9..26647};do awk '{print $"'${i}'", $1}' dist.csv  |sort -n |head -1 ;done > dist_category.csv

#R script for triads plot is in a seperate file.

#Step4: Compute the dominance type percentage
#bash

for cat in $(cat category.txt);do grep $cat dist_category_Leaf.csv | wc -l ; done
