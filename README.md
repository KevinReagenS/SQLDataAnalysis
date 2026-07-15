# SQL for Job Searching Purpose

## 📝 Introduction
This project aims to help me (the author) and general readers who want to explore "Data Analyst" roles in the job market, driven by the my desire to transition into the field. Instead of guessing what kind of jobs are best to look for and what skills are worth prioritizing, the data and the analysis presented in this repository will give the answers to the problems.

The dataset used here comes from 🔗[Luke Barousse 2023 Dataset](https://lukeb.co/sql_project_csvs)

💡 The guidelines that the author use comes in form of questions:
1) What skills should I learn first? [Hint: most demanded skills and top paid skills]
2) Which one has better yearly salary? Remote or on-site? Fulltime or contractor?
3) Do job postings that don't require a degree still pay competitively?
4) To better prepare before the contract is finished, in what month should I start applying jobs?

Here is the full SQL queries that will be analyzed throughout the documentation [SQL Project](./project_sql)

## 🛠️ Tools I Use

For this project, I use the following tools:

1️⃣ **PostgreSQL** ➜ Core programming language to query the database and answer the questions <br>
2️⃣ **pgAdmin** ➜ Act as PostgreSQL database <br>
3️⃣ **Visual Studio Code** ➜ IDE to write the query on <br>
4️⃣ **GitHub** ➜ Project's version control and host <br>
5️⃣ **Microsoft Excel** ➜ The raw data of the dataset is in .csv extension

## 📊 The Analysis
### 📶 Skill Prioritization
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
SQL, Excel, Python, Tableau, and PowerBI come at the top of the list of the most demanded skills at the job market. This confirms those five to be the most foundational skills for any aspiring data analyst. <br>

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
Not one skill between the most demanded skills table and top paid skills table is overlapping. This must cause confusion for the readers because now a new question arises, "So, what skills should I learn?" <br>

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

📢<span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Proof</span>
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

<br>
🛠️ <span style="background-color: #1a1a1a; color: #e05252; border: 1px solid #e05252; padding: 2px 8px; border-radius: 4px; font-family: monospace; font-weight: bold;">Solution</span><br>
To identify skills that are worth prioritizing, I need to filter out skills with too few job postings, for including them would cause the statistics to be skewed. I can think of two possible solutions, using median demand or mean demand.

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

The mean displays 13x time higher than the median which implies that this is a heavily right-skewed distribution (top skills: SQL, Excel, Python inflate the average). Using mean as the cut-off would have excluded a vast majority of the skills. So, I will use median for the cut-off value which is 169.

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

### 💲 Best Paid Jobs
TBD

### 👨🏻‍🎓 Does Degree Matter?
TBD

### 📅 Best Month to Apply?
TBD

## 🎓 What I learned

## 🎯 Conclusions