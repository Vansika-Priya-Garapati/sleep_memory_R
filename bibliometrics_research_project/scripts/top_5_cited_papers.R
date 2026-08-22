# Group 8 - Cognitive and Computational Neuroscience - ThinkNeuro
# Creating Top Cited Papers Table - Vansika Priya Garapati

# Load Packages
library(knitr)
library(kableExtra)
library(readr)
library(dplyr)

# 1. Load saved CSV data
csv_path <- "tables/top_10_most_cited_papers.csv"

if (!file.exists(csv_path)) {
  stop("CSV file not found! Make sure 'tables/top_10_most_cited_papers.csv' exists.")
}

top_cited_table <- read_csv(csv_path)

# 2. Filter down to top 5 and select core columns
top_5_table <- top_cited_table %>%
  head(5)

# 3. Build and save the Top 5 Table PDF
output_pdf <- "outputs/tables/top_5_most_cited_papers_table.pdf"

top_5_table %>%
  kbl(
    caption = "Top 5 Most Cited Papers",
    col.names = c("Citation Key", "Paper Title", "Journal", "Year", "Total Citations", "Cites / Year"),
    align = c("l", "l", "l", "c", "r", "r")
  ) %>%
  kable_classic(full_width = FALSE, html_font = "Arial") %>%
  # Styling tweaks for better sizing
  row_spec(0, bold = TRUE, color = "white", background = "#1F77B4") %>% # Blue header bar
  column_spec(2, width = "15em") %>%  # Wraps long paper titles so they don't push off-page
  save_kable(output_pdf)

message("Success! Saved Top 5 PDF table to: ", output_pdf)