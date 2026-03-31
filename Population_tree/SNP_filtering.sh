#!/bin/bash

#filtering vcf files with snp only maf=0.05, max missing rate 0.1, mac=3

vcftools --vcf HWG_189_Chr.bcftools.vcf --max-missing 0.9 --mac 3 --maf 0.05 --remove-indels --recode --recode-INFO-all --out HWG_189_filtered_miss5maf5snp

# VCF imputation
run_pipeline.pl -Xms16g -Xmx32g -importGuess HWG_189_filtered.vcf -LDKNNiImputationPlugin -highLDSSites 50 -knnTaxa 10 -maxLDDistance 100000000 -endPlugin -export HWG_189_filtered_imputed.vcf -exportType VCF

# LD pruning
plink --vcf HWG_189_filtered_imputed.vcf --indep-pairwise 50 10 0.2 --out HWG_189_filtered_imputed_LDfilter --allow-extra-chr

plink --vcf HWG_189_filtered_imputed.vcf --const-fid --extract HWG_189_filtered_imputed_LDfilter.prune.in --make-bed --recode vcf --out HWG_189_filtered_imputed_LD.vcf --allow-extra-chr

#filtering vcf files with hwe again
plink --vcf HWG_189_filtered_imputed_LD.vcf --maf 0.05 --geno 0.1 --hwe 1e-6 --mind 0.1 --make-bed --recode vcf --out HWG_189_filtered_imputed_LD_hwe.vcf --allow-extra-chr
