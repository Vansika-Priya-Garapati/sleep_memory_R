# Group 8 - Cognitive and Computational Neuroscience - ThinkNeuro
# Creating Top Cited Papers Table - Vansika Priya Garapati

# Install and Load Packages
# install.packages("kableExtra")
library(knitr)
library(kableExtra)
library(readr)

top_cited_table <- read_csv("tables/top_10_most_cited_papers.csv")

# Create PDF table styling
top_cited_table %>%
  kbl(caption = "Top 10 Most Cited Papers", booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped", "hold_position", "scale_down"))

# 1. Install required packages if not already installed
# install.packages("kableExtra")
# install.packages("webshot2") # Required for rendering tables to PDF/PNG images

library(knitr)
library(kableExtra)
library(readr)

# 2. Load your saved CSV
top_cited_table <- read_csv("tables/top_10_most_cited_papers.csv")

# 3. Build and save directly to PDF
pdf_table <- top_cited_table %>%
  kbl(
    caption = "Top 10 Most Cited Papers",
    col.names = c("Citation Key", "Paper Title", "Journal", "Year", "Total Citations", "Cites / Year"),
    align = c("l", "l", "l", "c", "r", "r")
  ) %>%
  kable_classic(full_width = FALSE, html_font = "Arial") %>%
  row_spec(0, bold = TRUE, color = "white", background = "#1F77B4") %>% # Sleek blue header
  save_kable("outputs/tables/top_10_most_cited_papers_table.pdf")

message("Saved table PDF to outputs/tables/top_10_most_cited_papers_table.pdf!")