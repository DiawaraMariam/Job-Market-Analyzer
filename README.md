# Job Market Trends Analyzer — AI & Data Science (2020–2026)

A data analysis project exploring job trends, salaries, and in-demand 
skills across AI, Machine Learning, and Data Science roles globally 
from 2020 to 2026.

## What this project does
- Analyzes salary trends across AI, ML, and Data Science roles
- Tracks how the job market evolved from 2020 to 2026
- Identifies the most in-demand skills by year and region
- Compares remote vs on-site opportunities across different roles
- Visualizes findings using Python and Power BI dashboards

## Tools used
- **Python** — data cleaning and analysis (pandas, matplotlib, seaborn)
- **Oracle SQL** — data storage and querying
- **Power BI** — interactive dashboards and visualizations

## Dataset
AI and Data Science Job Market Dataset (2020–2026) from Kaggle 
## Project structure
job-market-analyzer/
│
├── data/               # Raw and cleaned datasets
├── notebooks/          # Python analysis notebooks
├── sql/                # Oracle SQL scripts and queries
├── dashboard/          # Power BI dashboard files
└── README.md

## Key questions this project answers
1. Which AI and Data Science roles pay the most in 2026?
2. How have salaries changed from 2020 to 2026?
3. Which skills are most in demand right now?
4. How do salaries differ by country and experience level?
5. Is remote work growing or shrinking in AI and Data Science?



## Power BI Dashboard

An interactive dashboard built on the cleaned dataset (10,345 postings, 2020-2026).
Open `Job_Market_Dashboard.pbix` in Power BI Desktop to explore it.

### Overview
![Overview](screenshots/overview.png)

### Salary by Role
![Salary by Role](screenshots/salary_by_role.png)

### Skills in Demand
![Skills in Demand](screenshots/skills.png)

### Remote Work
![Remote Work](screenshots/remote_work.png)

### Salary by Country
![Salary by Country](screenshots/salary_by_country.png)

## Key Findings

- **Average salary is about $113K**, and it stays almost flat from 2020 to 2026 (roughly $113K-$114K each year).
- **AI Engineers and Machine Learning Engineers earn the most** (about $140K), while the other four roles sit around $100K.
- **Experience level drives pay more than location**: Senior is about $138K, Mid about $114K and Entry about $89K, with nearly the same gap in every country.
- **Skill demand is evenly spread**: Python, SQL, ML, deep learning and cloud each appear in a similar number of postings.
- **Remote work is stable**: about 34% of postings are remote, and the Remote/Hybrid/Onsite mix barely changes across years.

## Project status
Work in progress — actively being built
