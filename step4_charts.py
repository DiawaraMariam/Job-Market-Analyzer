# ============================================
# Step 4: Create Charts
# ============================================

# Import libraries
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the dataset - always needed first
df = pd.read_csv('data/ai_jobs_2020_2026.csv')

# Set a nice style for all charts
sns.set_style("whitegrid")

# -----------------------------------------------
# Chart 1: Average Salary by Job Title
# -----------------------------------------------

# Calculate average salary per job title
avg_salary = df.groupby('job_title')['salary'].mean().sort_values(ascending=False)

# Create the chart
plt.figure(figsize=(10, 6))
sns.barplot(x=avg_salary.values, y=avg_salary.index, palette='Blues_r')

# Add title and labels
plt.title('Average Salary by Job Title', fontsize=16)
plt.xlabel('Average Salary (USD)', fontsize=12)
plt.ylabel('Job Title', fontsize=12)

# Save the chart as an image
plt.tight_layout()
plt.savefig('charts/chart1_salary_by_jobtitle.png')
plt.show()
print("Chart 1 saved!")

# -----------------------------------------------
# Chart 2: Average Salary by Experience Level
# -----------------------------------------------

avg_exp = df.groupby('experience_level')['salary'].mean().sort_values(ascending=False)

plt.figure(figsize=(8, 5))
sns.barplot(x=avg_exp.index, y=avg_exp.values, palette='Greens_r')

plt.title('Average Salary by Experience Level', fontsize=16)
plt.xlabel('Experience Level', fontsize=12)
plt.ylabel('Average Salary (USD)', fontsize=12)

plt.tight_layout()
plt.savefig('charts/chart2_salary_by_experience.png')
plt.show()
print("Chart 2 saved!")

# -----------------------------------------------
# Chart 3: Remote vs Onsite vs Hybrid Jobs
# -----------------------------------------------

remote_counts = df['remote_type'].value_counts()

plt.figure(figsize=(7, 7))
plt.pie(remote_counts.values, labels=remote_counts.index, 
        autopct='%1.1f%%', colors=['#66b3ff','#99ff99','#ffcc99'])

plt.title('Remote vs Hybrid vs Onsite Jobs', fontsize=16)

plt.tight_layout()
plt.savefig('charts/chart3_remote_vs_onsite.png')
plt.show()
print("Chart 3 saved!")

# -----------------------------------------------
# Chart 4: Top Countries by Job Count
# -----------------------------------------------

top_countries = df['country'].value_counts().head(7)

plt.figure(figsize=(10, 6))
sns.barplot(x=top_countries.values, y=top_countries.index, palette='Oranges_r')

plt.title('Top Countries by Job Count', fontsize=16)
plt.xlabel('Number of Jobs', fontsize=12)
plt.ylabel('Country', fontsize=12)

plt.tight_layout()
plt.savefig('charts/chart4_top_countries.png')
plt.show()
print("Chart 4 saved!")

print("\nAll charts saved successfully!")
