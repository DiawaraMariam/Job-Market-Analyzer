# ============================================
# Step 2: Clean and explore the data
# ============================================
import pandas as pd

# Load the dataset - this is needed in every file
df = pd.read_csv('data/ai_jobs_2020_2026.csv')

# Check for missing values in each column
# This shows how many empty cells exist per column
print("\nMissing values per column:")
print(df.isnull().sum())

# Check for duplicate rows
# Duplicates can affect our analysis results
print("\nNumber of duplicate rows:")
print(df.duplicated().sum())

# Show basic statistics for all columns
# This gives us min, max, average for each column
print("\nBasic statistics:")
print(df.describe())

# Show all column names
# So we know exactly what data we are working with
print("\nColumn names:")
print(df.columns.tolist())