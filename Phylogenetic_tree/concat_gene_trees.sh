#!/bin/bash

for file in *tree_renamed.nwk; do awk 'BEGIN{ORS=" "} {print} END{print "\n"}' "$file"; done > all_gene_tree.nwk

sed -i 's/^ //g' all_gene_tree.nwk
