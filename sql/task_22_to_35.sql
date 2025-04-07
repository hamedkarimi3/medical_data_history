-- Task 22: Show the total number of male patients and the total number of female patients 
-- in the patients table. Display the two results in the same row.
select
    count(
        case
            when gender = 'M' then 1
        end
    ) as male_count,
    count(
        case
            when gender = 'F' then 1
        end
    ) as female_count
from
    patients;

-- Task 23:Show the patient_id, diagnosis from admissions. 
-- Find patients admitted multiple times for the same diagnosis.
select
    a.patient_id,
    a.diagnosis
FROM
    admissions a
GROUP BY
    a.patient_id,
    a.diagnosis
HAVING
    COUNT(*) > 1;

-- Task 24: Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.
SELECT
    city,
    COUNT(*) AS total_patients
FROM
    patients
GROUP BY
    city
ORDER BY
    total_patients DESC,
    city ASC;

-- Task 25: Show first_name, last_name, and role of every 
-- person that is either a patient or a doctor.
-- Roles are either "Patient" or "Doctor".
SELECT
    first_name,
    last_name,
    'Patient' AS role
FROM
    patients
UNION
-- Combine the results of both queries and remove duplicates
SELECT
    first_name,
    last_name,
    'Doctor' AS role
FROM
    doctors;

-- Task 26: Show all allergies ordered by popularity. Remove NULL values from the query.
select
    allergies,
    count(*) as total_allergies
from
    patients
where
    allergies is not null
group by
    allergies
order by
    total_allergies desc;

-- Task 27: Show all patient's first_name, last_name,
-- and birth_date who were born in the 1970s decade. 
-- Sort the list starting from the earliest birth_date.
SELECT
    first_name,
    last_name,
    birth_date
FROM
    patients
WHERE
    YEAR(birth_date) BETWEEN 1970
    AND 1979
ORDER BY
    birth_date ASC;

-- Task 28: 
-- We want to display each patient's full name in a single column.
-- Last name in all uppercase
-- First name in all lowercase
-- Format: LASTNAME,firstname
-- Order by first name in descending order.
-- Note: The first name should be in lowercase and the last name in uppercase.
SELECT
    CONCAT(
        UPPER(last_name),
        ',',
        LOWER(first_name)
    ) AS full_name
FROM
    patients
ORDER BY
    first_name DESC;

-- Task 29: Show the province_id(s) and the sum of height, 
-- where the total sum of that province's patients' height
-- is greater than or equal to 7,000.
SELECT
    province_id,
    SUM(height) AS total_height
FROM
    patients
GROUP BY
    province_id
HAVING
    SUM(height) >= 7000;

-- Task 30: Show the difference between the largest weight and smallest 
-- weight for patients with the last name 'Maroni'
SELECT
    MAX(weight) - MIN(weight) AS weight_difference
FROM
    patients
WHERE
    last_name = 'Maroni';

-- Task 31: Show all of the days of the month (1–31) and how many admission_dates
-- occurred on that day. Sort by the day with most admissions to least.
SELECT
    DAY(admission_date) AS day_of_month,
    COUNT(*) AS total_admissions
FROM
    admissions
GROUP BY
    DAY(admission_date)
ORDER BY
    total_admissions DESC;

-- Task 32: Show all of the patients grouped into weight groups.
-- Each group spans 10 units (e.g., 100–109 = group 100, 110–119 = group 110)
-- Show total number of patients in each group
SELECT
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS total_patients
FROM
    patients
GROUP BY
    weight_group
ORDER BY
    weight_group DESC;

-- Task 33:Show patient_id, weight, height, and isObese 
-- from the patients table.isObese is a boolean (0 or 1)
-- Obese if: weight (kg) / (height in meters)^2 ≥ 30
-- Weight is in kg, height is in cm → convert height to meters
SELECT
    patient_id,
    weight,
    height,
    CASE
        WHEN weight / ((height / 100) * (height / 100)) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM
    patients;

-- Task 34: 
-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only the patients who have a diagnosis as 'Epilepsy' 
-- and the doctor's first name is 'Lisa'.
select
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
from
    patients p
    join admissions a on p.patient_id = a.patient_id
    join doctors d on d.doctor_id = a.attending_doctor_id
where
    a.diagnosis = 'Epilepsy'
    and d.first_name = 'Lisa';

-- Task 35: 
-- Show the patient_id and temp_password for patients who have been admitted at least once.
-- The password is: patient_id + length of last_name + birth year.
SELECT
    p.patient_id,
    CONCAT (
        p.patient_id,
        LENGTH (p.last_name),
        YEAR (p.birth_date)
    ) AS temp_password
FROM
    patients p
WHERE
    p.patient_id IN (
        SELECT
            DISTINCT patient_id
        FROM
            admissions
    );