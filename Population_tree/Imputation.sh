#!/bin/bash

perl run_pipeline.pl -Xms8g -Xmx16g -importGuess HWG_189_filtered_miss9maf5snp.recode.vcf -LDKNNiImputationPlugin -highLDSSites 50 -knnTaxa 10 -maxLDDistance 100000000 -endPlugin -export HWG_189_filtered_imputated.vcf -exportType VCF
