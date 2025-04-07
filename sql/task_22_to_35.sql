-- Task 22: Show the number of admissions per patient
SELECT
    patient_id,
    count(*) as total_admissions
FROM
    admissions
GROUP BY
    patient_id;

-- Task 23:Show the first name, last name, and admission date of patients who were admitted more than once.
SELECT
    p.first_name,
    p.last_name,
    a.admission_date
FROM
    patients p
    JOIN admissions a ON p.patient_id = a.patient_id
WHERE
    a.patient_id IN (
        SELECT
            patient_id
        FROM
            admissions
        GROUP BY
            patient_id
        HAVING
            COUNT(*) > 1
    );

-- Task 24: Show the first name, last name, and number of admissions for each patient.
SELECT
    p.first_name,
    p.last_name,
    COUNT(a.patient_id) AS total_admissions
FROM
    patients p
    JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id;

-- Task 25: Show the first name, last name, and last admission date for each patient.
SELECT
    p.first_name,
    p.last_name,
    MAX(a.admission_date) AS last_admission_date
FROM
    patients p
    JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id;

-- Task 26: Show the number of patients admitted in each year
select
    year (admission_date) as admission_year,
    count(*) as total_patients
from
    admissions
group by
    year (admission_date)
order by
    admission_year;

-- Task 27: Show the first name, last name, and admission count for patients who were admitted in 2021
SELECT
    p.first_name,
    p.last_name,
    COUNT(a.patient_id) AS total_admissions
FROM
    patients p
    JOIN admissions a ON p.patient_id = a.patient_id
WHERE
    YEAR (a.admission_date) = 2021
GROUP BY
    p.patient_id;

-- Task 28: Show the first name, last name, and the doctor who admitted each patient.
SELECT
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name
FROM
    patients p
    JOIN admissions a ON p.patient_id = a.patient_id
    JOIN doctors d ON d.doctor_id = a.attending_doctor_id;

-- Task 29: Show the number of admissions handled by each doctor.
SELECT
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    COUNT(a.patient_id) AS total_admissions
FROM
    doctors d
    JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY
    d.doctor_id;

-- Task 30: Unique patients admitted by each doctor
SELECT
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    COUNT(DISTINCT a.patient_id) AS unique_patients -- distinct patients means no dublicates in the count and only count unique patients
FROM
    doctors d
    JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY
    d.doctor_id;

-- Task 31: Show the first name and last name of patients who were admitted by more than one doctor.
SELECT
    p.first_name,
    p.last_name
FROM
    patients p
    JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id
HAVING
    COUNT(DISTINCT a.attending_doctor_id) > 1;

-- Task 32: Show the doctor name and the number of different cities their patients are from.
select
    d.first_name,
    d.last_name,
    count(distinct p.city) as unique_patients
from
    doctors d
    join admissions a on a.attending_doctor_id = d.doctor_id
    join patients p on p.patient_id = a.patient_id
group by
    d.doctor_id;

-- Task 33: Show the patient full name and the number of doctors who have admitted them.
select
    concat (p.first_name, ' ', p.last_name) as full_name,
    count(distinct a.attending_doctor_id) as total_doctors
FROM
    patients p
    join admissions a on p.patient_id = a.patient_id
    join doctors d on doctor_id = a.attending_doctor_id
group by
    p.patient_id;

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
        SELECT DISTINCT
            patient_id
        FROM
            admissions
    );