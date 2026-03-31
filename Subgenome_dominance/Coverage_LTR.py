#!/usr/bin/env python3

def process_coverage(input_file, output_file):
    """
    Process coverage data for dominant genes to calculate average coverage per window.
    
    Args:
        input_file (str): Path to the input coverage file (e.g., LTR_counts_dominant_windows.txt).
        output_file (str): Path to the output file (e.g., dominant_coverage_average.txt).
    """
    # Initialize dictionaries with default empty lists for each position (1 to 500)
    coverage_5_prime = {str(i): [] for i in range(1, 501)}
    coverage_3_prime = {str(i): [] for i in range(1, 501)}

    with open(input_file, 'r') as infile:
        for line in infile:
            fields = line.strip().split('\t')
            if len(fields) < 5:  # Ensure at least 5 columns
                continue

            chrom = fields[0]
            start = fields[1]
            end = fields[2]
            name = fields[3]
            count = int(fields[4])  # Convert count to integer

            # Parse name to extract prime, strand, and position
            name_parts = name.split('_')
            prime = name_parts[-3]  # e.g., 5prime
            strand = name_parts[-2]  # e.g., +
            position = name_parts[-1]  # e.g., 1

            # Handle position as integer
            pos = int(position)

            if prime == "5prime":
                if strand == "+":
                    coverage_5_prime[position].append(count)
                elif strand == "-":
                    position_reverse = str(501 - pos)  # Reverse position for - strand
                    coverage_5_prime[position_reverse].append(count)
            elif prime == "3prime":
                if strand == "+":
                    coverage_3_prime[position].append(count)
                elif strand == "-":
                    position_reverse = str(501 - pos)
                    coverage_3_prime[position_reverse].append(count)

    # Write averages for 5' prime regions
    with open(output_file, 'w') as outfile:
        for pos, counts in coverage_5_prime.items():
            if counts:  # Only process if there are counts
                avg_coverage = sum(counts) / len(counts)
                outfile.write(f"{pos}\t{avg_coverage}\t'5prime'\n")

    # Write averages for 3' prime regions
        for pos, counts in coverage_3_prime.items():
            if counts:
                avg_coverage = sum(counts) / len(counts)
                outfile.write(f"{pos}\t{avg_coverage}\t'3prime'\n")

if __name__ == '__main__':
    input_file = "LTR_counts_dominant_windows.txt"
    output_file = "dominant_coverage_average.txt"
    process_coverage(input_file, output_file)
