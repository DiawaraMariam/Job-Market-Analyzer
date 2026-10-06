-- ============================================
-- Job Market Trends Analyzer
-- 01: Create table (Oracle SQL)
-- ============================================

DROP TABLE ai_jobs PURGE;

CREATE TABLE ai_jobs (
    job_id                NUMBER          PRIMARY KEY,
    job_title             VARCHAR2(100),
    company_size          VARCHAR2(50),   -- Startup, MNC, Medium, Enterprise
    company_industry      VARCHAR2(50),   -- Retail, Technology, Healthcare, Finance, Education, ...
    country                VARCHAR2(50),
    remote_type            VARCHAR2(20),   -- Remote, Hybrid, Onsite
    experience_level       VARCHAR2(20),   -- Entry, Mid, Senior
    years_experience       NUMBER(4),
    education_level        VARCHAR2(20),   -- Bachelor, Master, PhD
    skills_python           NUMBER(1),      -- 0/1 flag
    skills_sql              NUMBER(1),
    skills_ml                NUMBER(1),
    skills_deep_learning      NUMBER(1),
    skills_cloud             NUMBER(1),
    salary                  NUMBER(10),
    job_posting_month        NUMBER(2),
    job_posting_year         NUMBER(4),
    hiring_urgency           VARCHAR2(10),  -- Low, Medium, High
    job_openings              NUMBER(5)
);

-- Helpful indexes for the queries in 03_analysis_queries.sql
CREATE INDEX ix_ai_jobs_year        ON ai_jobs (job_posting_year);
CREATE INDEX ix_ai_jobs_title       ON ai_jobs (job_title);
CREATE INDEX ix_ai_jobs_country     ON ai_jobs (country);
CREATE INDEX ix_ai_jobs_exp_level   ON ai_jobs (experience_level);
