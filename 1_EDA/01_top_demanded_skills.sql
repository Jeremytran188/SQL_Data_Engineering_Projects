/*
Question: What are the most in-demand skills for data engineers?

- Identify the top 10 most in-demand skills for data engineers.
- Focus on job postings in Australia.

Why?
- Retrieve the top 10 skills with the highest demand in the remote
  job market.
- Provide insights into the most valuable skills for data engineers
  seeking remote work.
*/
SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_country = 'Australia' AND jpf.job_title_short = 'Data Engineer'
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most demanded skills for data engineers in Australia:
SQL and Python are the most in-demand skills, with ~4,400 and ~3,800 job postings respectively.
Cloud platforms follow closely, with Azure leading at ~3,000 postings, followed by AWS at ~2,700.
Spark (~1,700) and Databricks (~1,500) highlight the importance of big data processing.
Snowflake, Java, Scala, and Power BI round out the top 10, each with around 900–1,100 postings.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers.
- Cloud platforms (Azure, AWS) are critical for modern data engineering.
- Big data tools like Spark and Databricks are highly valued.
- Snowflake highlights the demand for cloud data warehousing.
- Java, Scala, and Power BI demonstrate the value of programming and analytics skills.

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │         4426 │
│ python     │         3786 │
│ azure      │         2986 │
│ aws        │         2746 │
│ spark      │         1742 │
│ databricks │         1504 │
│ snowflake  │         1114 │
│ java       │         1078 │
│ scala      │          904 │
│ power bi   │          885 │
└────────────┴──────────────┘
│ 10 rows         2 columns │
└───────────────────────────┘
*/