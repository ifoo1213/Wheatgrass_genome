#!/bin/bash

# convert the vcf to fasta alignment file
python2 vcf2phylip.py -i HWG_189_filtered_miss9maf5snp.recode.vcf -o ./PI685580 --fasta --nexus

# iqtree inference phylogenetic tree
iqtree2 -s HWG_189_filtered_miss9maf5snp.recode.min4.fasta -B 1000 -alrt 1000
