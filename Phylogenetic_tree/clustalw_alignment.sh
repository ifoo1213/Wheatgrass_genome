#!/bin/bash


for file in *.fasta
do
	prefix=`echo $file | sed 's/.fasta//g'`
	clustalw -INFILE=$file -TYPE=PROTEIN -OUTFILE=$prefix.aln.fa -OUTPUT=FASTA
        echo '$prefix.aln.fa is done'
done
