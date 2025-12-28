# analysis.R
# Script to replicate and extend yield data analysis from NAS report

# Load required libraries
library(dplyr)
library(readr)

# Read data
study_data <- read_csv("study_data.csv")

# Calculate overall mean yield difference (original method)
mean_yield_diff <- mean(study_data$yield_percent_difference, na.rm = TRUE)

# Print original result
cat("Overall mean yield difference (%):", round(mean_yield_diff, 2), "\n")

# ==============================================
# IMPROVED ANALYSIS: Stratify by study duration
# ==============================================
# Issue #42 identified that study duration is a confounding variable.
# Longer-term studies may show different effects than short-term ones.
# We stratify studies into short-term (<3 years) and long-term (>=3 years)
# to examine potential differences.

# Create duration category
study_data <- study_data %>%
  mutate(duration_category = ifelse(duration_in_years < 3, "short-term (<3 years)", "long-term (>=3 years)"))

# Calculate mean yield difference by duration category
stratified_stats <- study_data %>%
  group_by(duration_category) %>%
  summarise(
    n_studies = n(),
    mean_yield = mean(yield_percent_difference, na.rm = TRUE),
    sd_yield = sd(yield_percent_difference, na.rm = TRUE),
    min_yield = min(yield_percent_difference, na.rm = TRUE),
    max_yield = max(yield_percent_difference, na.rm = TRUE)
  )

cat("\n--- Stratified by study duration ---\n")
print(stratified_stats)

# Optional: overall summary statistics (unchanged)
summary_stats <- study_data %>%
  summarise(
    n_studies = n(),
    mean_yield = mean(yield_percent_difference, na.rm = TRUE),
    sd_yield = sd(yield_percent_difference, na.rm = TRUE),
    min_yield = min(yield_percent_difference, na.rm = TRUE),
    max_yield = max(yield_percent_difference, na.rm = TRUE)
  )
cat("\n--- Overall summary (for reference) ---\n")
print(summary_stats)