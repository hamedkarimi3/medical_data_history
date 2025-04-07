-- Task 11: Total number of admissions
select
    count(*) as total_admissions
from
    admissions;

-- Task 12: Show all the columns from admissions where 
-- the patient was admitted and discharged on the same day.
select
    *
from
    admissions
where
    admission_date = discharge_date;

-- Task 13: Show the total number of admissions for patient_id 579
select
    count(*) as total_admissions_579
from
    admissions
where
    patient_id = 579;

-- Task 14:Based on the cities that our patients live in,
-- show unique cities that are in province_id = 'NS'
select distinct
    city
from
    patients
where
    province_id = 'NS';

-- Task 15: Write a query to find the first_name,
-- last_name, and birth_date of patients who have 
-- height more than 160 and weight more than 70
select
    first_name,
    last_name,
    birth_date
from
    patients
where
    height > 160
    and weight > 70;

-- Task 16: Show unique birth years from patients
-- and order them by ascending.
SELECT DISTINCT
    YEAR (birth_date) as birth_year
FROM
    patients
ORDER BY
    birth_year ASC;

-- Task 17: Show unique first names from the patients
-- table which only occur once in the list.
-- (Hint: Use HAVING because WHERE doesn't work with aggregate functions)
select
    first_name
from
    patients
group by
    first_name
having
    count(*) = 1;

-- Task 18: Show patient_id and first_name from patients where their 
-- first_name starts and ends with 's' and is at least 6 characters long.
SELECT
    patient_id,
    first_name
FROM
    patients
WHERE
    first_name LIKE 's%'
    AND first_name LIKE '%s'
    AND LENGTH (first_name) >= 6;

-- Task 19: Show patient_id, first_name, 
-- and last_name from patients whose diagnosis is 'Dementia'.
-- (Diagnosis is stored in the admissions table.)
SELECT
    p.patient_id,
    p.first_name,
    p.last_name
FROM
    patients p
    JOIN admissions a ON p.patient_id = a.patient_id
WHERE
    a.diagnosis = 'Dementia';

-- Task 20: Display every patient's first_name. Order 
-- the list by the length of each name and then alphabetically.
SELECT
    first_name
FROM
    patients
ORDER BY
    LENGTH (first_name),
    first_name ASC;

-- Task 21: Show the total number of male patients and the total
-- number of female patients in the patients table. Display the 
-- two results in the same row.
SELECT
    COUNT(
        CASE
            WHEN gender = 'M' THEN 1
        END
    ) AS male_count,
    COUNT(
        CASE
            WHEN gender = 'F' THEN 1
        END
    ) AS female_count
FROM
    patients