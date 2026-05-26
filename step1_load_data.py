# ============================================
# Job Market Trends Analyzer
# Step 1: Load and explore the dataset
# ============================================

# Import pandas - reads and works with our data
import pandas as pd

# Import matplotlib - creates charts
import matplotlib.pyplot as plt

# Import seaborn - creates beautiful charts
import seaborn as sns

# Load the dataset into a dataframe called df
df = pd.read_csv('data/ai_jobs_2020_2026.csv')

# Print success message
print("Dataset loaded successfully!")

# Print number of rows and columns
print("Shape:", df.shape)

# Print first 5 rows
print(df.head())


# ============================================
# Step 2: Clean and explore the data
# ============================================

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