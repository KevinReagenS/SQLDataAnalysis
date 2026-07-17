# SQL for Job Searching Purpose

## 📝 Introduction
<div style="text-align: justify"> This project aims to help me (the author) and general readers who want to explore "Data Analyst" roles in the job market, driven by my desire to transition into the field. Instead of guessing what kind of jobs are best to look for and what skills are worth prioritizing, the data and the analysis presented in this repository will give the answers to the problems. </div><br>

The dataset used here comes from 🔗[Luke Barousse 2023 Dataset](https://lukeb.co/sql_project_csvs)

💡 The guidelines that I use comes in form of questions:
1) What skills should I learn first? [Hint: most demanded skills and top paid skills]
2) Which one has better yearly salary? Remote or on-site? Fulltime or contractor?
3) To better prepare before the contract is finished, in what month should I start applying jobs?

Here is the full SQL queries that will be analyzed throughout the documentation [SQL Project](./project_sql)

## 🛠️ Tools I Use

For this project, I use the following tools:

1️⃣ **PostgreSQL** ➜ Core programming language to query the database and answer the questions <br>
2️⃣ **pgAdmin** ➜ Act as PostgreSQL database <br>
3️⃣ **Visual Studio Code** ➜ IDE to write the query on <br>
4️⃣ **GitHub** ➜ Project's version control and host <br>
5️⃣ **Microsoft Excel** ➜ The raw data of the dataset is in .csv extension

## 📊 The Analysis
### 📶 Skill Prioritization [SQL File](project_sql/skills_to_learn_first.sql)
The most optimal skills could be thoroughly calculated by integrating the most demanded skills and the most paid skills.

#### Most demanded skills
❓<span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Business Question</span>:<br>
"Which skills appear the most frequently in the dataset?"
<br> <br>
👨🏻‍💻 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Query</span>

```sql
-- Most demanded skills
SELECT
    skills.skills,
    COUNT(job_postings.job_id) AS total_jobs
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job
    ON skills_to_job.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills
    ON skills.skill_id = skills_to_job.skill_id
WHERE
    job_postings.job_title LIKE '%Data%Analyst%' AND
    job_postings.job_title NOT LIKE '%Senior%' AND
    job_postings.job_title NOT LIKE '%Sr%'
GROUP BY
    skills.skills
ORDER BY
    total_jobs DESC
```

🧩 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Reasoning</span> <br>
ㆍThrowing away "Senior" title on the ```WHERE``` clause in assumption that when someone pivots their career into a new field, it is expected to first look for junior or entry level. <br>
ㆍ```INNER JOIN``` is used instead of other ```JOIN``` to exterminate jobs that are not associated with any skills and vice versa.

✅ <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Result</span>
| Skill     | Total Jobs |
|-----------|------------|
| SQL       | 76,120     |
| Excel     | 55,838     |
| Python    | 46,441     |
| Tableau   | 38,264     |
| Power BI  | 32,309     |
| R         | 24,149     |
| SAS       | 22,380     |
| PowerPoint| 11,122     |
| Word      | 10,988     |
| Sap       | 8,885      |

<br>
🧐 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Insight</span> <br>
<div style="text-align: justify">SQL, Excel, Python, Tableau, and PowerBI come at the top of the list of the most demanded skills at the job market. This confirms those five to be the most foundational skills for any aspiring data analyst. </div><br>

--- 
#### Top paid skills
❓<span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Business Question</span> <br>
"Which skills are associated with the highest average yearly salaries?"
<br> <br>
👨🏻‍💻 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Query</span>

```sql
-- Top paid skills
SELECT
    skills.skills,
    ROUND(AVG(job_postings.salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job
    ON skills_to_job.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills
    ON skills.skill_id = skills_to_job.skill_id
WHERE
    job_postings.job_title LIKE '%Data%Analyst%' AND
    job_postings.job_title NOT LIKE '%Senior%' AND
    job_postings.job_title NOT LIKE '%Sr%' AND
    job_postings.salary_year_avg IS NOT NULL
GROUP BY
    skills.skills
ORDER BY
    average_salary DESC
```

✅ <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Result</span>
| Skill      | Average Salary |
|------------|----------------:|
| Ansible    | $159,640        |
| DataRobot  | $155,486        |
| dplyr      | $147,633        |
| VMware     | $147,500        |
| Golang     | $145,000        |
| Twilio     | $138,500        |
| Puppet     | $129,820        |
| Perl       | $128,264        |
| GitLab     | $122,517        |
| Bitbucket  | $116,712        |

<br>
🧐 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Insight</span> <br>
<div style="text-align: justify">Not one skill between the most demanded skills table and top paid skills table is overlapping. This must cause confusion for the readers because now a new question arises, "So, what skills should I learn?" </div><br>

---
#### Optimal Skills (Demand + Top Salary Integration)
⚠️ <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Previous problem</span><br>
Top 10 highest paid skills do not match the top 10 most demanded skills

💭 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Assumption</span><br>
The highest paid skills must have appeared seldomly in the job postings dataset, making the list deviates and the averages unreliable

🕵 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Assumption Proof</span>
```sql
-- Ranking Top Paid Skills Based on Job Counts
SELECT
    skills.skills,
    ROUND(AVG(job_postings.salary_year_avg), 0) AS average_salary,
    ROW_NUMBER() OVER (ORDER BY COUNT(job_postings.job_id) DESC) rank_job_counts
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job
    ON skills_to_job.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills
    ON skills.skill_id = skills_to_job.skill_id
WHERE
    job_postings.job_title LIKE '%Data%Analyst%' AND
    job_postings.job_title NOT LIKE '%Senior%' AND
    job_postings.job_title NOT LIKE '%Sr%' AND
    job_postings.salary_year_avg IS NOT NULL
GROUP BY
    skills.skills
ORDER BY
    average_salary DESC
```

| Skill      | Average Salary | Rank (by Job Count)    |
|------------|----------------:|----------------------:|
| Ansible    | $159,640        | 166                   |
| DataRobot  | $155,486        | 156                   |
| dplyr      | $147,633        | 127                   |
| VMware     | $147,500        | 161                   |
| Golang     | $145,000        | 167                   |
| Twilio     | $138,500        | 139                   |
| Puppet     | $129,820        | 143                   |
| Perl       | $128,264        | 82                    |
| GitLab     | $122,517        | 114                   |
| Bitbucket  | $116,712        | 108                   |

👉 The highest ranked skill which is "Perl" doesn't even sit at the top 50. 👈

<br>
🛠️ <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Solution</span><br>
<div style="text-align: justify">To identify skills that are worth prioritizing, I need to filter out skills with too few job postings, for including them would cause the statistics to be skewed. I can think of two possible solutions, using median demand or mean demand.</div><br>

```sql
-- Percentile
WITH skill_counts AS (
    SELECT
        skills.skills,
        COUNT(job_postings.job_id) AS total_jobs
    FROM
        job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS skills_to_job
        ON skills_to_job.job_id = job_postings.job_id
    INNER JOIN skills_dim AS skills
        ON skills.skill_id = skills_to_job.skill_id
    WHERE
        job_postings.job_title LIKE '%Data%Analyst%' AND
        job_postings.job_title NOT LIKE '%Senior%' AND
        job_postings.job_title NOT LIKE '%Sr%'
    GROUP BY
        skills.skills
)

SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_jobs) AS median_demand,
    ROUND(AVG(total_jobs), 0) AS average_demand
FROM
    skill_counts
```

| Median     | Mean    |
|------------|--------:|
| 169        | 2,219   |

<div style="text-align: justify">The mean displays 13x time higher than the median which implies that this is a heavily right-skewed distribution (top skills: SQL, Excel, Python inflate the average). Using mean as the cut-off would have excluded a vast majority of the skills. So, I will use median for the cut-off value which is 169.</div><br>

```sql
-- Top paid skills
SELECT
    skills.skills,
    ROUND(AVG(job_postings.salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job
    ON skills_to_job.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills
    ON skills.skill_id = skills_to_job.skill_id
WHERE
    job_postings.job_title LIKE '%Data%Analyst%' AND
    job_postings.job_title NOT LIKE '%Senior%' AND
    job_postings.job_title NOT LIKE '%Sr%' AND
    job_postings.salary_year_avg IS NOT NULL
GROUP BY
    skills.skills
HAVING
    COUNT(job_postings.job_id) > 169
ORDER BY
    average_salary DESC
```

| Skill      | Average Salary  |
|------------|----------------:|
| Snowflake  | $107,539        |
| Looker     | $100,969        |
| AWS        | $99,629         |
| Python     | $99,625         |
| Oracle     | $98,886         |
| Azure      | $97,889         |
| R          | $96,815         |
| Tableau    | $96,397         |
| Flow       | $96,181         |
| SQL        | $94,666         |

### 💲 Best Paid Jobs [SQL File](/project_sql/better_salary_job_type.sql)
The best paid jobs could be found by combining two factors: job location (remote or on-site) and job type

👨🏻‍💻 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Query</span>
```sql
SELECT
    job_schedule_type,
    job_work_from_home,
    ROUND(AVG(salary_year_avg), 0) AS average_salary,
    COUNT(job_id) AS total_jobs
FROM
    job_postings_fact
WHERE
    job_schedule_type IS NOT NULL AND
    salary_year_avg IS NOT NULL AND
    (
        job_title LIKE '%Data%Analyst%' AND
        job_title NOT LIKE '%Senior' AND
        job_title NOT LIKE '%Sr%'
    ) AND
    job_schedule_type IN ('Full-time', 'Contractor', 'Part-time', 'Internship', 'Temp work')
GROUP BY
    job_schedule_type,
    job_work_from_home
ORDER BY
    job_schedule_type,
    job_work_from_home
```

✅ <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Result</span>

| Job Schedule Type | Remote (WFH) | Average Salary | Total Jobs    |
|--------------------|:------------:|----------------:|------------:|
| Contractor         | FALSE        | $86,357          | 117        |
| Contractor         | TRUE         | $94,139          | 18         |
| Full-time          | FALSE        | $95,425          | 4,595      |
| Full-time          | TRUE         | $97,265          | 654        |
| Internship         | FALSE        | $79,000          | 7          |
| Part-time          | FALSE        | $79,559          | 26         |
| Part-time          | TRUE         | $82,850          | 2          |
| Temp work          | FALSE        | $72,778          | 9          |

🧩 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Reasoning</span> <br>

Unlike the first question, I won't clip the data by applying median total jobs. The reason behind this is when I apply median to this table, almost every job type is eliminated, hence neither comparison nor conlusion could be made from the data.

🧐 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Insight</span> <br>

Across all three schedule types with any remote presence (Contractor, Full-time, and Part-time), remote roles show a higher average salary than their on-site counterparts. However, only Full-time has a sample size large enough on both sides to trust this pattern (4,595 on-site vs. 654 remote). Contractor (117 vs. 18) and Part-time (26 vs. 2) show the same directional trend, but the sample size of both job types is simply too small, making it impossible to draw any reliable conclusions.

### 📅 Best Month to Apply? [SQL File](/project_sql/best_month_apply.sql)
This question will be the finishing touch of the job-searching journey. After figuring out which skills to prioritize and what job type to aim, the final showdown is to decide when to apply for your dream jobs.

👨🏻‍💻 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Query</span>

```sql
-- Monthly
SELECT
    TO_CHAR(job_posted_date::DATE, 'Month') AS month_name,
    COUNT(job_id) AS total_jobs
FROM
    job_postings_fact
WHERE
    (
        job_title LIKE '%Data%Analyst%' AND
        job_title NOT LIKE '%Senior%' AND
        job_title NOT LIKE '%Sr%'
    ) AND
    salary_year_avg IS NOT NULL AND
    EXTRACT(YEAR FROM job_posted_date::DATE) <> 2022
GROUP BY
    month_name,
    EXTRACT(MONTH FROM job_posted_date::DATE)
ORDER BY
    total_jobs DESC


-- Quarterly
SELECT
    EXTRACT(QUARTER FROM job_posted_date::DATE) AS quarter,
    COUNT(job_id) AS total_jobs
FROM
    job_postings_fact
WHERE
    (
        job_title LIKE '%Data%Analyst%' AND
        job_title NOT LIKE '%Senior%' AND
        job_title NOT LIKE '%Sr%'
    ) AND
    salary_year_avg IS NOT NULL AND
    EXTRACT(YEAR FROM job_posted_date::DATE) <> 2022
GROUP BY
    quarter
ORDER BY
    total_jobs DESC
```
🧩 <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Reasoning</span> <br>

After excluding 2022 (a partial month, not representative) from the dataset, the remaining 12 months of 2023 show a clear downward trend in job posting volume across the year: Q1 leads with 1,387 postings, declining steadily through Q2 (1,308), Q3 (1,191), and Q4 (958). This pattern suggests job-seeker have more opportunities (~31%) than the last three months of the year.

✅ <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Result</span>

<table>
<tr>
<td>

| Month     | Total Jobs |
|-----------|-----------:|
| January   | 555        |
| July      | 479        |
| June      | 476        |
| August    | 456        |
| March     | 435        |
| May       | 419        |
| April     | 413        |
| February  | 397        |
| December  | 383        |
| November  | 299        |
| October   | 276        |
| September | 256        |

</td>
<td>

| Quarter | Total Jobs |
|---------|-----------:|
| Q1      | 1,387      |
| Q2      | 1,308      |
| Q3      | 1,191      |
| Q4      | 958        |

</td>
</tr>
</table>

> ⚠️This dataset only spans one calendar year. While the pattern is internally consistent, it can't be confirmed factually as a recurring annual trend, as doing so would require multiple years comparison.

## 🎓 What I learned

Through this project, I strengthened my SQL practical knowledge and developed a more rigorous approach to drawing conclusions from data:<br><br>
1️⃣ Combined multiple tables using ```JOIN``` and knew when to use ```INNER JOIN``` or ```LEFT JOIN```. Carefully used CTEs and window functions to answer multi-step questions (```ROW_NUMBER()``` AND ```PERCENTILE_CONT```) <br>
2️⃣ Learnt not to immediately trust raw data without considering sample sizes. Sample size matters! <br>
3️⃣ Realized that real-world data is messy and contained multiple jumbled data. I learnt to narrow the data and document it with a defensible decision <br>

## 🎯 Conclusions
1) The top 10 optimal skills [Optimal Skills (Demand + Top Salary Integration)](#optimal-skills-demand--top-salary-integration) combine market demands and salary. Both the top 5 and bottom 5 skills in this list share a distinct theme: Cloud/BI tools offer premium salaries over general-purpose programming languages.
2) For aspiring data analysts, the combination of full-time and remote job offers the highest salary category among all job types followed by contractor job type, but the claim about contractor's remote salary can't be drawn due to unreliable sample size.
3) For better preparation, job-seekers should focus their applications in the first half of the year (particularly Q1), which saw the highest posting volume (1,387 jobs). Posting activity declines steadily through the second half of the year, dropping to just 958 jobs by Q4, a ~31% decrease from the year's peak. Note that this pattern is based on a single year of data (2023), so it should be treated as a directional signal rather than a confirmed seasonal trend.