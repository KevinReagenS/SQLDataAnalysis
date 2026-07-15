/*
I am an aspiring data analyst trying to pivot into the field. I have Electrical Engineer background and a little bit of programming knowledge.
But, I am not able to immediately resign from my current job for I am still bound by contract and will be punished by severe penalty if I do.

What factors should I weigh when deciding which roles to pursue and which skills to learn?

Questions to answer:
1) What skills should I learn first? [Hint: most demanded skills and top paid skills]
2) Which one has better yearly salary? Remote or on-site? Fulltime or contractor?
3) Do job postings that don't require a degree still pay competitively?
4) To better prepare before the contract is finished, in what month should I start applying jobs?
*/

SELECT DISTINCT
    job_schedule_type,
    COUNT(job_id) AS total_jobs
FROM
    job_postings_fact AS job_postings
WHERE
    job_schedule_type IS NOT NULL
GROUP BY
    job_schedule_type
ORDER BY
    total_jobs DESC
LIMIT 1000

TBD