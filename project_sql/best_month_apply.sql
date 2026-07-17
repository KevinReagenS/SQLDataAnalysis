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
        job_title NOT LIKE '%Sr&'
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
        job_title NOT LIKE '%Sr&'
    ) AND
    salary_year_avg IS NOT NULL AND
    EXTRACT(YEAR FROM job_posted_date::DATE) <> 2022
GROUP BY
    quarter
ORDER BY
    total_jobs DESC