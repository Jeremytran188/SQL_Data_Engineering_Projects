/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?

- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus on Data Engineer positions in Australia.

Why?
- This approach highlights skills that balance market demand and financial reward. 
  It weights core skills appropriately instead of letting rare, outlier skills distort the results.
- The natural log transformation ensures that both high-salary and widely in-demand skills surface <<
  as the most practical and valuable to learn for data engineering careers.
*/
SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1_000_000, 2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'Australia'
GROUP BY
    sd.skills
HAVING 
    COUNT(sjd.job_id) >= 100
ORDER BY
    optimal_score DESC
LIMIT 25;

/*
Here's a breakdown of the most optimal skills for Data Engineers in Australia, balancing market demand and median salary:
- AWS ranks first with the highest optimal score of 0.99, combining a median salary of $124,900 with ~2,700 job postings.
- Cassandra follows closely with a score of 0.98 and the highest median salary of $205,000, despite relatively low demand (~120 postings).
- SSIS ranks third with a score of 0.97, offering a strong median salary of $160,000 across ~430 postings.
- Python and SQL both achieve scores of 0.97, supported by the highest demand (~3,800 and ~4,400 postings) and median salaries of $117,500 and $115,000, respectively.
- Databricks (0.90) and Azure (0.87) also demonstrate a strong balance between salary and demand, with ~1,500 and ~3,000 postings respectively.

Key takeaways:
- AWS offers the strongest overall balance of market demand and median salary, ranking first in the optimal score.
- Cassandra and SSIS achieve high scores primarily due to their higher median salaries, despite lower demand.
- SQL and Python remain essential skills, combining widespread demand with competitive salaries.
- Cloud and data engineering technologies (AWS, Azure, Databricks) consistently rank highly, highlighting their importance in the Australian job market.
- Specialised skills can offer higher salaries, but widely demanded skills provide broader employment opportunities.
- Balancing salary and demand provides a more practical approach to prioritising skills than focusing on either metric alone.

Limitations:
- Limited salary data: Most job postings do not disclose salaries, making median salary estimates less reliable.
- Potential ranking bias: Salary estimates are based on a small subset of postings, while demand includes all postings, potentially inflating scores for certain skills.
- Exploratory results: The optimal score is a custom metric, so rankings should be interpreted cautiously rather than as definitive measures of skill value.

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ aws        │      124900.0 │         2746 │             7.9 │          0.99 │
│ cassandra  │      205000.0 │          118 │             4.8 │          0.98 │
│ ssis       │      160000.0 │          434 │             6.1 │          0.97 │
│ python     │      117500.0 │         3786 │             8.2 │          0.97 │
│ sql        │      115000.0 │         4426 │             8.4 │          0.97 │
│ nosql      │      147500.0 │          437 │             6.1 │           0.9 │
│ databricks │      123290.0 │         1504 │             7.3 │           0.9 │
│ azure      │      108179.0 │         2986 │             8.0 │          0.87 │
│ git        │      133750.0 │          609 │             6.4 │          0.86 │
│ jenkins    │      147500.0 │          338 │             5.8 │          0.86 │
│ spark      │      111000.0 │         1742 │             7.5 │          0.83 │
│ go         │      133500.0 │          423 │             6.0 │          0.81 │
│ javascript │      155000.0 │          165 │             5.1 │          0.79 │
│ pyspark    │      129250.0 │          460 │             6.1 │          0.79 │
│ sql server │      120000.0 │          677 │             6.5 │          0.78 │
│ redshift   │      113775.0 │          776 │             6.7 │          0.76 │
│ scala      │      111000.0 │          904 │             6.8 │          0.76 │
│ kafka      │      111275.0 │          833 │             6.7 │          0.75 │
│ power bi   │      109141.5 │          885 │             6.8 │          0.74 │
│ oracle     │      115507.0 │          559 │             6.3 │          0.73 │
│ bitbucket  │      147500.0 │          135 │             4.9 │          0.72 │
│ snowflake  │      102550.0 │         1114 │             7.0 │          0.72 │
│ powershell │      131580.0 │          217 │             5.4 │          0.71 │
│ java       │       99661.5 │         1078 │             7.0 │           0.7 │
│ gcp        │      102550.0 │          792 │             6.7 │          0.68 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
│ 25 rows                                                           5 columns │
└─────────────────────────────────────────────────────────────────────────────┘

