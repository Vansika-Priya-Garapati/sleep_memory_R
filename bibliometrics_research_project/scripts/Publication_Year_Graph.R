# Group 8 - Cognitive and Computational Neuroscience - ThinkNeuro
# Creating Change in Publications over Time Line Graph - Vansika Priya Garapati

# Load Packages
library(dplyr)
library(ggplot2)
library(bibliometrix)
library(tidyr)

# M as Data Frame
M <- convert2df("data/diane_data.bib", dbsource = "wos", format = "bibtex")

# 1.Summary of groups in data frame M
df_growth <- M %>%
  filter(!is.na(PY)) %>%
  group_by(PY) %>%
  summarise(Articles = n()) %>%
  rename(Year = PY) %>%
  mutate(Year = as.numeric(as.character(Year))) %>%
  complete(Year = min(Year):2026, fill = list(Articles = 0)) %>%
  arrange(Year)

df_growth$Year <- as.numeric(as.character(df_growth$Year))

# Find the maximum value to ensure labels have room at the top
max_articles <- max(df_growth$Articles, na.rm = TRUE)

# 2. Build plot
p_growth <- ggplot(df_growth, aes(x = Year, y = Articles)) +
  geom_line(color = "#1F77B4", linewidth = 1.2) +
  geom_point(color = "#1F77B4", size = 3) +
  
  # Add data plots
  geom_text(
    aes(label = Articles), 
    vjust = -0.8,         # Positions text slightly above the point
    size = 3.5,           # Font size for the numbers
    fontface = "bold",    # Makes numbers pop
    color = "#1F77B4"
  ) +
  
  # X-Axis
  scale_x_continuous(
    breaks = seq(min(df_growth$Year), max(df_growth$Year), by = 1)
  ) +
  
  # Y-axis
  scale_y_continuous(
    breaks = seq(0, max_articles + 4, by = 2),
    limits = c(0, max_articles + 2)
  ) +
  
  labs(
    title = "Change in Scientific Publications Over Time",
    x = "Publication Year",
    y = "Number of Publications"
  ) +
  
  theme_minimal(base_size = 14) +
  
  # No Grid Lines
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    axis.line = element_line(color = "black", linewidth = 0.8),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# 3. Save as  PDF
pdf("outputs/publications_over_time_line_graph_2026.pdf", width = 10, height = 5)
print(p_growth)
dev.off()

message("All done!")