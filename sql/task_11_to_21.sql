-- Task 11: Total number of admissions
select
    count(*) as total_admissions
from
    admissions;

-- Task 12: Count male and female patients
select
    gender,
    count(*) as total_pationts
from
    patients
GROUP BY
    gender;

-- Task 13: Count of patients in each city
select
    city,
    count(*) as total_city_patients
from
    patients
GROUP BY
    city;

-- Task 14: Patients with weight greater than 100
select
    *
from
    patients
where
    weight > 100;

-- Task 15: Patients with height between 160 and 180
select
    first_name,
    last_name,
    height
from
    patients
where
    height between 160 and 180;

-- Task 16: Show the number of patients for each birth year.
SELECT
    YEAR (birth_date) AS birth_year,
    COUNT(*) AS total_patients
FROM
    patients
GROUP BY
    YEAR (birth_date)
ORDER BY
    birth_year;

-- Task 17: Show the first name, last name, and BMI of all patients (BMI = weight in kg / (height in meters)^2)
select
    first_name,
    last_name,
    weight / ((height / 100) * (height / 100)) as BMI
from
    patients;

-- Task 18: Show the first name, last name, and BMI of patients who are obese.(Assume obese = BMI ≥ 30)
SELECT
    first_name,
    last_name,
    weight / ((height / 100) * (height / 100)) as BMI
from
    patients
where
    weight / ((height / 100) * (height / 100)) >= 30;

-- Task 19: Show the first name, last name, and birth year of patients who were born before 1990.
SELECT
    first_name,
    last_name,
    year (birth_date) as birth_year
from
    patients
where
    year (birth_date) < 1990;

-- Task 20: Show the first name, last name, and birth date of the youngest patient.
SELECT
    first_name,
    last_name,
    birth_date
FROM
    patients
ORDER BY
    birth_date DESC
LIMIT
    1;

-- Task 21: Show the first name, last name, and admission date of patients admitted in the year 2021.
SELECT
    first_name,
    last_name,
    admission_date
FROM
    patients
    JOIN admissions ON patients.patient_id = admissions.patient_id
WHERE
    YEAR (admission_date) = 2021;