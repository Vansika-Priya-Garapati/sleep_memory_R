# Group 8 - Cognitive and Computational Neuroscience - ThinkNeuro
# Creating Keyword Co-Occurrence Network - Vansika Priya Garapati


# Load bibliometrix
library(bibliometrix)


# Define color palette
blue       <- "#2C7FB8"
light_blue <- "#DCEEF7"
final_blue <- "#E6F2F8"
dark_blue  <- "#1F5F8B"
gray_text  <- "gray35"

# 1. Load data
bib_df <- convert2df("data/diane_data.bib", dbsource = "wos", format = "bibtex")

# 2. Build Keyword Co-occurrence Network
NetMatrix_kw <- biblioNetwork(
  bib_df,
  analysis = "co-occurrences",
  network = "keywords",
  sep = ";"
)

# Plot the network
networkPlot(
  NetMatrix_kw,
  n = 30,
  Title = "Keyword Co-Occurrence Network",
  type = "kamada",
  size = 3,
  labelsize = 0.7,
  label.color = TRUE,
  remove.isolates = TRUE,
  cluster = "louvian" # Apply Louvian for multiple colors
)

# Subtitle
mtext(
  "Relationships Among Most Frequently Occurring Keywords in the Top 100 Papers",
  side = 3,
  line = 0.5,
  adj = 0.5,
  col = gray_text,
  font = 3,
  cex = 0.85
)

# Save whatever plot is currently showing in my Plots pane as PDF
dev.copy2pdf(file = "Keyword_Cooccurrence_Network.pdf", width = 10, height = 8)

cat("Saved directly from your Plots pane!\n")

# Keyword_Cooccurrence_Network.pdf manually moved to outputs/ folder