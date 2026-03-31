from ete3 import Tree

# Function to simplify species names based on prefix
def simplify_name(name):
    # Split the name by underscore
    parts = name.split('_')
    

    simplified = parts[0]  # keep the first one name
    
    return simplified

# Directory containing your gene tree files
input_dir = "."
output_dir = "./renamed_trees"

# Create output directory if it doesn't exist
import os
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Process each gene tree file
for filename in os.listdir(input_dir):
    if filename.endswith('_tree.txt'):
        input_path = os.path.join(input_dir, filename)
        output_path = os.path.join(output_dir, filename.replace('.txt', '_renamed.nwk'))

        # Read the tree
        tree = Tree(input_path, format=1)

        # Rename each leaf
        for leaf in tree:
            original_name = leaf.name
            if original_name:  # Ensure the node has a name
                new_name = simplify_name(original_name)
                leaf.name = new_name

        # Write the renamed tree to a new file
        tree.write(format=1, outfile=output_path)
        print(f"Processed {filename} -> {output_path}")

print("Renaming complete!")
