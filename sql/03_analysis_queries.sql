-- ============================================
-- Job Market Trends Analyzer
-- 03: Analysis queries (Oracle SQL)
--
-- Each block answers one of the "Key questions this project
-- answers" from the README.
-- ============================================

-- --------------------------------------------
-- Q1: Which AI/Data Science roles pay the most in 2026?
-- --------------------------------------------
SELECT job_title,
       ROUND(AVG(salary), 0)  AS avg_salary,
       COUNT(*)                AS job_count
FROM   ai_jobs
WHERE  job_posting_year = 2026
GROUP BY job_title
ORDER BY avg_salary DESC;


-- --------------------------------------------
-- Q2: How have salaries changed from 2020 to 2026?
-- --------------------------------------------
SELECT job_posting_year,
       ROUND(AVG(salary), 0)                                   AS avg_salary,
       ROUND(AVG(salary) - LAG(AVG(salary)) OVER (ORDER BY job_posting_year), 0) AS yoy_change,
       COUNT(*)                                                 AS job_count
FROM   ai_jobs
GROUP BY job_posting_year
ORDER BY job_posting_year;

-- Same trend, broken out by job title, useful for a Power BI line chart
SELECT job_posting_year,
       job_title,
       ROUND(AVG(salary), 0) AS avg_salary
FROM   ai_jobs
GROUP BY job_posting_year, job_title
ORDER BY job_posting_year, job_title;


-- --------------------------------------------
-- Q3: Which skills are most in demand right now?
--     (skills_* columns are 0/1 flags, so SUM = count of postings requiring it)
--     "Right now" = most recent year in the data.
-- --------------------------------------------
SELECT 'Python'        AS skill, SUM(skills_python)        AS demand_count
FROM   ai_jobs WHERE job_posting_year = (SELECT MAX(job_posting_year) FROM ai_jobs)
UNION ALL
SELECT 'SQL',            SUM(skills_sql)            FROM ai_jobs WHERE job_posting_year = (SELECT MAX(job_posting_year) FROM ai_jobs)
UNION ALL
SELECT 'Machine Learning', SUM(skills_ml)            FROM ai_jobs WHERE job_posting_year = (SELECT MAX(job_posting_year) FROM ai_jobs)
UNION ALL
SELECT 'Deep Learning',  SUM(skills_deep_learning)   FROM ai_jobs WHERE job_posting_year = (SELECT MAX(job_posting_year) FROM ai_jobs)
UNION ALL
SELECT 'Cloud',          SUM(skills_cloud)           FROM ai_jobs WHERE job_posting_year = (SELECT MAX(job_posting_year) FROM ai_jobs)
ORDER BY demand_count DESC;

-- Skill demand trend by year (feeds a Power BI multi-line chart)
SELECT job_posting_year,
       SUM(skills_python)      AS python_demand,
       SUM(skills_sql)         AS sql_demand,
       SUM(skills_ml)          AS ml_demand,
       SUM(skills_deep_learning) AS deep_learning_demand,
       SUM(skills_cloud)       AS cloud_demand
FROM   ai_jobs
GROUP BY job_posting_year
ORDER BY job_posting_year;


-- --------------------------------------------
-- Q4: How do salaries differ by country and experience level?
-- --------------------------------------------
SELECT country,
       experience_level,
       ROUND(AVG(salary), 0) AS avg_salary,
       COUNT(*)               AS job_count
FROM   ai_jobs
GROUP BY country, experience_level
ORDER BY country, DECODE(experience_level, 'Entry', 1, 'Mid', 2, 'Senior', 3);

-- Pivoted version: one row per country, one column per experience level
SELECT *
FROM (
    SELECT country, experience_level, salary
    FROM   ai_jobs
)
PIVOT (
    ROUND(AVG(salary), 0)
    FOR experience_level IN ('Entry' AS entry, 'Mid' AS mid, 'Senior' AS senior)
)
ORDER BY country;


-- --------------------------------------------
-- Q5: Is remote work growing or shrinking?
-- --------------------------------------------
SELECT job_posting_year,
       remote_type,
       COUNT(*) AS job_count,
       ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY job_posting_year), 1) AS pct_of_year
FROM   ai_jobs
GROUP BY job_posting_year, remote_type
ORDER BY job_posting_year, remote_type;


-- --------------------------------------------
-- Extra: overall summary numbers, handy for Power BI KPI cards
-- --------------------------------------------
SELECT COUNT(*)                          AS total_postings,
       ROUND(AVG(salary), 0)             AS avg_salary,
       COUNT(DISTINCT country)           AS countries_covered,
       COUNT(DISTINCT job_title)         AS distinct_roles,
       MIN(job_posting_year)             AS first_year,
       MAX(job_posting_year)             AS last_year
FROM   ai_jobs;
