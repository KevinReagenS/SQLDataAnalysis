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
        job_title NOT LIKE '%Senior%' AND
        job_title NOT LIKE '%Sr%'
    ) AND
    job_schedule_type IN ('Full-time', 'Contractor', 'Part-time', 'Internship', 'Temp work')
GROUP BY
    job_schedule_type,
    job_work_from_home
ORDER BY
    job_schedule_type,
    job_work_from_home