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