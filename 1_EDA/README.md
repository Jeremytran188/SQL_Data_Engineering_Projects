# 🔍 Exploratory Data Analysis w/ SQL: Job Market Analytics

![EDA Project Overview](../Resources/images/1_1_Project1_EDA.png)

A SQL project analyzing the data engineer job market in Australia using real world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

---

## 🧾 Executive Summary (For Hiring Managers)

- ✅ **Project scope:** Built **3 analytical queries** that answer key questions about the data engineer job market in Australia 
- ✅ **Data modeling:** Used **multi-table joins** across fact and dimension tables to extract insights  
- ✅ **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and overall value  
- ✅ **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, and salary patterns

If you only have a minute, review these:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) – demand analysis with multi-table joins  
2. [`02_top_paying_skills.sql`](./02_top_paying_skills.sql) – salary analysis with aggregations  
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) – combined demand/salary optimization query  

---

## 🧩 Problem & Context

Job market analysts need to answer questions like:

- 🎯 **Most in-demand:** *Which skills are most in-demand for data engineers in Australia?*  
- 💰 **Highest paid:** *Which skills command the highest salaries?*  
- ⚖️ **Best trade-off:** *What is the optimal skill set balancing demand and compensation?*  

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:

![Data Warehouse Schema](../Resources/images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` - Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- **Dimension Tables:** 
  - `company_dim` - Company information linked to job postings
  - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and optimal skill combinations for data engineering roles.  

---

## 🧰 Tech Stack

- 🐤 **Query Engine:** DuckDB for fast OLAP-style analytical queries  
- 🧮 **Language:** SQL (ANSI-style with analytical functions)  
- 📊 **Data Model:** Star schema with fact + dimension + bridge tables  
- 🛠️ **Development:** VS Code for SQL editing + Terminal for DuckDB CLI  
- 📦 **Version Control:** Git/GitHub for versioned SQL scripts  

---

## 📂 Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql    # Demand analysis query
├── 02_top_paying_skills.sql      # Salary analysis query
├── 03_optimal_skills.sql         # Combined demand/salary optimization
└── README.md                     # You are here
```
---

## 🏗 Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** – Identifies the 10 most in-demand skills for data engineer positions in Australia
2. **[Top Paying Skills](./02_top_paying_skills.sql)** – Analyzes the 25 highest-paying skills with salary and demand metrics
3. **[Optimal Skills](./03_optimal_skills.sql)** – Calculates an optimal score using natural log of demand combined with median salary to identify the most valuable skills to learn

### Key Insights

- 🧠 Core languages: SQL and Python are the most in-demand skills in the Australian dataset, appearing in 4,426 and 3,786 Data Engineer postings, respectively.
- ☁️ Cloud platforms: Azure leads cloud demand with 2,986 postings, while AWS appears in 2,746 and earns the highest combined demand and salary score (0.99).
- 🧱 Infra & tooling: Cassandra and SSIS lead the observed salary ranking at $205,000 and $160,000, respectively. Limited salary disclosure makes these estimates exploratory.
- 🔥 Big data tools: Apache Spark and Databricks show strong demand, appearing in 1,742 and 1,504 postings, respectively. Databricks also ranks highly on the combined score (0.90).

## Data Quality & Limitations

During the exploratory data analysis and data validation process, two significant data quality issues were identified.

### Missing Salary Currency Metadata

The dataset contains annual and hourly salary information but does not include a currency attribute.

An investigation of salary distributions across different countries suggests that salary values are predominantly denominated in USD. However, this cannot be definitively verified from the source documentation.

**Impact:** International salary comparisons may be inaccurate if multiple currencies are present.

### Geographical Classification Inconsistency

An investigation revealed inconsistencies between the `job_country` and `job_location` columns.

Of the 2,797 job postings containing annual salary information classified under Sudan:

- **2,090 (74.72%)** had United States locations.
- **689 (24.63%)** were listed as "Anywhere".
- **17 (0.61%)** had missing location information.
- **1 (0.04%)** explicitly listed a location in Sudan.

**Impact:** Country-level job market analysis and geographical salary comparisons may produce misleading results.

**Proposed solution:** Implement geographical validation and standardisation rules in a separate transformation layer while preserving the original source data. Ambiguous records should be flagged for further investigation.

---

## 💻 SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Joins**: Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping**: `GROUP BY` for categorical analysis by skill
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics**: Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause**: Filtering aggregated results (skills with >= 100 postings)
- **NULL Handling**: Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)