# Group 8 - Cognitive and Computational Neuroscience - ThinkNeuro
# Creating Top Cited CSV File - Vansika Priya Garapati

# Load Packages
library(dplyr)
library(readr)
library(stringr)

# Set reference year for citations-per-year calculation
current_year <- 2026

# 1. Clean, extract, and rank top cited papers from M
top_cited_df <- M %>%
  filter(!is.na(TC) & !is.na(TI)) %>%
  mutate(
    TC = as.numeric(TC),
    PY = as.numeric(PY),
    
    # Clean up title formatting to Title Case
    Title = str_to_title(TI),
    
    # Extract first author
    First_Author = str_extract(SR, "^[A-Z0-9\\s\\-]+"),
    
    # Create Citation Key (e.g., "PARISI GI (2019)")
    Paper = paste0(First_Author, " (", PY, ")"),
    
    # Calculate Citations Per Year
    Years_Active = (current_year - PY) + 1,
    Cites_Per_Year = round(TC / ifelse(Years_Active <= 0, 1, Years_Active), 2)
  ) %>%
  arrange(desc(TC)) %>%
  head(10) %>%
  
  
  # Select and rename final columns for the table
  select(
    Paper,
    Title,
    Journal = SO,
    Year = PY,
    Total_Citations = TC,
    Cites_Per_Year
  )

# 2. Save to your tables folder
if (!dir.exists("tables")) dir.create("tables", recursive = TRUE)

write_csv(top_cited_df, "tables/top_10_most_cited_papers.csv")

message("Saved CSV to tables/top_10_most_cited_papers.csv!")