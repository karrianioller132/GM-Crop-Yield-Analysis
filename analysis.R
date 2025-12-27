# analysis.R
# Script to replicate and extend yield data analysis from NAS report

# Load required libraries
library(dplyr)
library(readr)

# Read data
study_data <- read_csv("study_data.csv")

# Calculate overall mean yield difference
mean_yield_diff <- mean(study_data$yield_percent_difference, na.rm = TRUE)

# Print results
cat("Overall mean yield difference (%):", round(mean_yield_diff, 2), "\n")

# Optional: summary statistics
summary_stats <- study_data %>%
  summarise(
    n_studies = n(),
    mean_yield = mean(yield_percent_difference, na.rm = TRUE),
    sd_yield = sd(yield_percent_difference, na.rm = TRUE),
    min_yield = min(yield_percent_difference, na.rm = TRUE),
    max_yield = max(yield_percent_difference, na.rm = TRUE)
  )
print(summary_stats)