-- ============================================
-- Job Market Trends Analyzer
-- 02: SQL*Loader control file
--
-- Loads data/ai_jobs_2020_2026.csv into the ai_jobs table.
--
-- Run from the command line (adjust userid to your own):
--   sqlldr userid=your_user/your_password@your_db \
--          control=sql/02_load_data.ctl \
--          log=sql/load.log bad=sql/load.bad
--
-- If you don't have SQL*Loader available (e.g. you're on Oracle
-- Cloud/Autonomous DB or a hosted SQL Developer instance), use
-- SQL Developer's "Import Data" wizard on the CSV instead and
-- point it at the ai_jobs table created in 01_create_table.sql.
-- ============================================

LOAD DATA
INFILE 'data/ai_jobs_2020_2026.csv'
APPEND
INTO TABLE ai_jobs
-- the CSV has a header row, skip it
SKIP 1
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    job_id,
    job_title,
    company_size,
    company_industry,
    country,
    remote_type,
    experience_level,
    years_experience,
    education_level,
    skills_python,
    skills_sql,
    skills_ml,
    skills_deep_learning,
    skills_cloud,
    salary,
    job_posting_month,
    job_posting_year,
    hiring_urgency,
    job_openings
)
