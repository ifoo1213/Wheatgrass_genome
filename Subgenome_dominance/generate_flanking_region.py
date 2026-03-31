#!/usr/bin/env python3

import sys

def extract_flanking_regions(input_file, output_file):
    """
    Extract 5 kb flanking regions (5' and 3') for genes based on strand orientation.
    
    Args:
        input_file (str): Path to the input BED file (e.g., Dominant.bed).
        output_file (str): Path to the output BED file (e.g., dominant_flanking.bed).
    """
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            fields = line.strip().split('\t')
            if len(fields) < 5:  # Ensure at least 6 columns (chrom, start, end, name, strand)
                continue
                
            chrom = fields[0]
            start = int(fields[1])
            end = int(fields[2])
            gene = fields[3]
            strand = fields[4]
            
            if strand == '+':
                five_start = max(0, start - 5000)  # Prevent negative start
                five_end = start
                three_start = end
                three_end = end + 5000
            else:
                five_start = end
                five_end = end + 5000
                three_start = max(0, start - 5000)
                three_end = start
            
            # Write 5' flanking region
            outfile.write(f"{chrom}\t{five_start}\t{five_end}\t{gene}_5prime_{strand}\n")
            # Write 3' flanking region
            outfile.write(f"{chrom}\t{three_start}\t{three_end}\t{gene}_3prime_{strand}\n")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python extract_flanking_regions.py input.bed output.bed")
        sys.exit(1)
    
    input_file = sys.argv[1]  # e.g., Dominant.bed
    output_file = sys.argv[2]  # e.g., dominant_flanking.bed
    extract_flanking_regions(input_file, output_file)
