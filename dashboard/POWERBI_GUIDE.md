# Power BI Dashboard Guide — Job Market Trends Analyzer

This walks through building the dashboard on top of `ai_jobs` (either the
raw CSV or the Oracle table from `sql/01_create_table.sql`).

## 1. Get the data

**Option A — from Oracle (recommended once the SQL step is done):**
`Get Data → More → Database → Oracle Database`. Point it at your Oracle
instance, select the `ai_jobs` table (or paste one of the queries from
`sql/03_analysis_queries.sql` as a native query).

**Option B — straight from CSV:**
`Get Data → Text/CSV` and select `data/ai_jobs_2020_2026.csv`.

## 2. Power Query (Transform Data) steps

1. Set correct types: `job_id`→Whole Number, `salary`→Whole Number,
   `years_experience`/`job_posting_month`/`job_posting_year`/`job_openings`→Whole
   Number, everything else (`job_title`, `country`, `remote_type`,
   `experience_level`, `education_level`, `company_size`,
   `company_industry`, `hiring_urgency`) → Text.
2. Create a **Date** column from `job_posting_year` + `job_posting_month`
   (`Add Column → Custom Column`):
   ```
   #date([job_posting_year], [job_posting_month], 1)
   ```
   This gives you a real date field for time-axis charts and lets you
   build a Date table off it if you want proper time intelligence.
3. Create a **Skills** table for skill-demand analysis. The five
   `skills_*` columns are 0/1 flags, which is awkward to chart directly.
   Right-click `ai_jobs` → **Reference** to make a new query, keep just
   `job_id`, `job_posting_year`, `skills_python`, `skills_sql`,
   `skills_ml`, `skills_deep_learning`, `skills_cloud`, then
   **Unpivot Columns** on the five skill columns. Rename the resulting
   `Attribute`/`Value` columns to `Skill` / `HasSkill`, and filter
   `HasSkill = 1`. Now you have one row per (job, skill required) — a
   proper fact table for a skill-demand bar/line chart.

## 3. Data model

- `ai_jobs` (main fact table) — one row per job posting.
- `Skills` (from step 3 above) — related to `ai_jobs` on `job_id`
  (many-to-one, single direction).
- Optional: a standalone **Date** table marked as a date table, related
  to `ai_jobs[Date]`, if you want native Power BI time-intelligence
  functions (YTD, SAMEPERIODLASTYEAR, etc.) instead of the manual
  year-over-year measure below.

## 4. Core DAX measures

```dax
Avg Salary = AVERAGE(ai_jobs[salary])

Job Postings = COUNTROWS(ai_jobs)

Remote % =
DIVIDE(
    CALCULATE(COUNTROWS(ai_jobs), ai_jobs[remote_type] = "Remote"),
    COUNTROWS(ai_jobs)
)

Avg Salary PY =
CALCULATE(
    [Avg Salary],
    FILTER(ALL(ai_jobs[job_posting_year]), ai_jobs[job_posting_year] = MAX(ai_jobs[job_posting_year]) - 1)
)

Salary YoY % = DIVIDE([Avg Salary] - [Avg Salary PY], [Avg Salary PY])

Skill Demand % =
DIVIDE(
    CALCULATE(COUNTROWS(Skills)),
    CALCULATE(COUNTROWS(ai_jobs), ALL(Skills[Skill]))
)
```

## 5. Suggested pages (maps to the README's key questions)

**Page 1 — Overview**
- KPI cards: `[Job Postings]`, `[Avg Salary]`, `[Remote %]`, countries covered
- Line chart: `[Avg Salary]` by `job_posting_year` (Q2)
- Slicers across the top: `job_posting_year`, `country`, `experience_level`

**Page 2 — Salary Analysis**
- Bar chart: `[Avg Salary]` by `job_title`, sorted descending, filtered to
  the latest year (Q1)
- Matrix/table: `[Avg Salary]` by `country` × `experience_level` (Q4)
- Box plot or clustered bar: salary by `education_level`

**Page 3 — Skills in Demand**
- Bar chart: count of `Skill` from the `Skills` table, filtered to latest
  year (Q3)
- Line chart: skill count by `job_posting_year`, one line per `Skill`,
  to show trend over time

**Page 4 — Remote Work & Geography**
- Stacked bar or 100% stacked bar: `remote_type` by `job_posting_year`,
  to show the remote/hybrid/onsite mix shifting over time (Q5)
- Map or bar chart: `Job Postings` by `country`
- Donut chart: `remote_type` split, filtered to latest year

## 6. Formatting notes

- Use a consistent color per `remote_type` (Remote/Hybrid/Onsite) and per
  `experience_level` (Entry/Mid/Senior) across every page — set this once
  in the field's default color and it'll carry through all visuals.
- Add a report-level slicer or bookmark for `job_posting_year` so every
  page can be filtered to "latest year" with one click.
