/*
Question: What are the highest-paying skills for data engineers?

- Calculate the median salary for each skill required in data engineer positions.
- Focus on job postings in Australia with specified salaries.
- Include skill frequency to identify both salary and demand.

Why?
- Helps identify which skills command the highest compensation while also
  showing how common those skills are, providing a more complete picture
  for skill development priorities.
- The median is used instead of the average to reduce the impact of
  outlier salaries.
*/
SELECT
  sd.skills,
  ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
  COUNT(*) AS demand_count
FROM 
  job_postings_fact AS jpf
INNER JOIN
  skills_job_dim AS sjd
  ON jpf.job_id = sjd.job_id
INNER JOIN 
  skills_dim AS sd
  ON sd.skill_id = sjd.skill_id
WHERE jpf.job_country = 'Australia'
  AND job_title_short= 'Data Engineer'
GROUP BY 
  sd.skills
HAVING 
  COUNT(*) > 100
ORDER BY median_salary DESC 
LIMIT 25;

/*
Here's a breakdown of the highest-paying skills for Data Engineers in Australia:
Cassandra leads with the highest median salary at $205,000, followed by SSIS at $160,000 and JavaScript at $155,000.
NoSQL, Bitbucket, and Jenkins share a median salary of $147,500, highlighting the value of database and DevOps skills.
AWS ($124,900) and Databricks ($123,290) offer strong salaries alongside high demand, with ~2,700 and ~1,500 postings respectively.
SQL and Python remain the most in-demand skills, with ~4,400 and ~3,800 postings, despite lower median salaries of $115,000 and $117,500.

Key takeaways:
- Cassandra offers the highest median salary but has relatively low demand.
- Database and DevOps skills (NoSQL, Jenkins, Git) command competitive salaries.
- AWS and Databricks provide a strong balance between salary and job demand.
- SQL and Python remain essential due to their widespread demand.
- Specialised skills can command higher salaries, but demand should also guide learning priorities.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ cassandra  │      205000.0 │          118 │
│ ssis       │      160000.0 │          434 │
│ javascript │      155000.0 │          165 │
│ nosql      │      147500.0 │          437 │
│ bitbucket  │      147500.0 │          135 │
│ jenkins    │      147500.0 │          338 │
│ git        │      133750.0 │          609 │
│ go         │      133500.0 │          423 │
│ powershell │      131580.0 │          217 │
│ pyspark    │      129250.0 │          460 │
│ aws        │      124900.0 │         2746 │
│ databricks │      123290.0 │         1504 │
│ confluence │      120000.0 │          222 │
│ ansible    │      120000.0 │          118 │
│ sql server │      120000.0 │          677 │
│ pandas     │      120000.0 │          116 │
│ python     │      117500.0 │         3786 │
│ oracle     │      115507.0 │          559 │
│ excel      │      115000.0 │          294 │
│ sql        │      115000.0 │         4426 │
│ redshift   │      113775.0 │          776 │
│ kafka      │      111275.0 │          833 │
│ sas        │      111213.0 │          312 │
│ scala      │      111000.0 │          904 │
│ spark      │      111000.0 │         1742 │
└────────────┴───────────────┴──────────────┘
│ 25 rows                          3 columns│  
└───────────────────────────────────────────┘
*/