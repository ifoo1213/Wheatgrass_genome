library(ggplot2)
library(ggtern)



# Read the data
tpm <- read.table("Normalized_TPM_all_tissue.txt", header = FALSE, sep = "\t")
colnames(tpm) <- c("Gene", "H", "St1", "St2", "Tissue")

dist_cat <- read.table("dist_category_all.csv", header = FALSE, sep = " ")
colnames(dist_cat) <- c("Distance", "Group")
dist_cat$Gene <- as.character(1:nrow(dist_cat))

# Merge the data
data <- merge(tpm[8:nrow(tpm), ], dist_cat, by = "Gene")

# Check the column names after merging (for debugging)
# print(colnames(data))

# Handle the Tissue column name after merge (it might be Tissue.x or Tissue.y)
# If Tissue.x exists, use it; otherwise, use Tissue.y or Tissue
if ("Tissue.x" %in% colnames(data)) {
  data$Tissue <- data$Tissue.x
} else if ("Tissue.y" %in% colnames(data)) {
  data$Tissue <- data$Tissue.y
}

# Scale the data to percentages (assuming H, St1, St2 sum to 1)
data$H <- data$H * 100
data$St1 <- data$St1 * 100
data$St2 <- data$St2 * 100

# Define a custom color palette to match the previous plot
group_colors <- c(
  "Balance" = "red",
  "H_dominance" = "brown",
  "H_suppressed" = "green",
  "St1_dominance" = "cyan",
  "St1_suppressed" = "blue",
  "St2_dominance" = "purple",
  "St2_suppressed" = "pink"
)

# Define a shape palette for tissues
# Get the unique tissue types
tissue_types <- unique(data$Tissue)
# Assign shapes to each tissue type (e.g., 21: circle, 22: square, 23: diamond, etc.)
shape_values <- c("Flower" = 3, "Root" = 4, "Stem" = 24, "Leaf" = 21)

#shape_values <- setNames(21:(21 + length(tissue_types) - 1), tissue_types)


# Plot the ternary diagram
p <- ggtern(data = data, aes(x = H, y = St1, z = St2, color = Group, shape = Tissue)) +
  theme_rgbw() +
  geom_point(aes(fill = Group), size = 0.4) +
  scale_color_manual(values = group_colors) +
  scale_fill_manual(values = group_colors) +
  scale_shape_manual(values = shape_values) +
  labs(x = "H", y = "St1", z = "St2") +
  theme(legend.position = "right") +
  theme_showarrows()  # Show arrows on the axes

# Display the plot
print(p)

# Save the plot
ggsave("HWG_Ternary_Plot_all.pdf", plot = p, width = 8, height = 6)