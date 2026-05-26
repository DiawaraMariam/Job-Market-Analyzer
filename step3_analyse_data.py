import pandas as pd

# Load the dataset - this is needed in every file
df = pd.read_csv('data/ai_jobs_2020_2026.csv')

# ============================================
# Step 3: Analyze the data
# ============================================

# Question 1: What are the top 10 most common job titles?
print("\nTop 10 Job Titles:")
print(df['job_title'].value_counts().head(10))

# Question 2: What is the average salary by job title?
print("\nAverage Salary by Job Title:")
print(df.groupby('job_title')['salary'].mean().sort_values(ascending=False).head(10))

# Question 3: What is the average salary by experience level?
print("\nAverage Salary by Experience Level:")
print(df.groupby('experience_level')['salary'].mean().sort_values(ascending=False))

# Question 4: Which countries have the most jobs?
print("\nTop 10 Countries by Job Count:")
print(df['country'].value_counts().head(10))

# Question 5: How many jobs are remote vs on-site?
print("\nRemote vs On-site Jobs:")
print(df['remote_type'].value_counts())