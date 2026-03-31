#!/bin/bash

iqtree2 -t all_gene_tree.nwk -m MFP -b 1000 -nt AUTO -o Os
