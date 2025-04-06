show databases;
use project_medical_data_history;
show tables;


-- Task 1: Show first name, last name, and gender of male patients
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

-- Task 2. Show first name and last name of patients who do not have allergies.
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;

-- Task 3. Show first name of patients that start with the letter 'C'
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';

-- Task 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

-- Task 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

-- Task 6. Show first name and last name concatenated into one column to show their full name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Task 7. Show first name, last name, and the full province name of each patient.
SELECT p.first_name, p.last_name, pn.province_name
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id;

-- Task 8. Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS count_2010_births
FROM patients
WHERE YEAR(birth_date) = 2010;

-- Task 9. Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name, last_name, height
FROM patients
ORDER BY height DESC
LIMIT 1;

-- Task 10. Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

-- Task 11. Show the total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- Task 12: Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- Task 13: Show the total number of admissions for patient_id 579.
SELECT COUNT(*) AS admissions_for_579
FROM admissions
WHERE patient_id = 579;

-- Task 14: Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';

-- Task 15: Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70;

-- Task 16: Show unique birth years from patients and order them by ascending.
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;

-- Task 17: Show unique first names from the patients table which only occurs once in the list.For example, if two or more people are named 'John' in the first_name column
--then don't include their name in the output list. If only 1 person is named 'Leo'then include them in the output. Tip: HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;

-- Task 18: Show patient_id and first_name from patients where their first_name starts and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%' AND first_name LIKE '%s'
  AND LENGTH(first_name) >= 6;

-- Task 19: Show patient_id, first_name, last_name from patients whose diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

-- Task 20: Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;

-- Task 21: Show the total number of male patients and the total number of female patients in the patients table. Display the two results in the same row.
SELECT
  COUNT(CASE WHEN gender = 'M' THEN 1 END) AS male_count,
  COUNT(CASE WHEN gender = 'F' THEN 1 END) AS female_count
FROM patients;

-- Task 22: Show the total number of male patients and the total number of female patients in the patients table. Display the two results in the same row.
-- Task 22 repeated question same solution as task 21

-- Task 23: Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- Task 24: Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

-- Task 25: Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

-- Task 26: Show all allergies ordered by popularity. Remove NULL values from the query.
SELECT allergies, COUNT(*) AS frequency
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY frequency DESC;

-- Task 27: Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

-- Task 28: We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name
--with a comma. Order the list by the first_name in descending order EX: SMITH,jane
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

-- Task 29:  Show the province_id(s) and sum of height, where total height is >= 7000
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING total_height >= 7000;

-- Task 30: Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- Task 31: Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS admission_count
FROM admissions
GROUP BY day_of_month
ORDER BY admission_count DESC;

-- Task 32: Show all of the patients grouped into weight groups. Show the total number of patients in each weight group. Order the list by the weight group descending. e.g. if they weigh 100 to 109 they are placed 
--in the 100 weight group, 110-119 = 110 weight group, etc.
SELECT FLOOR(weight / 10) * 10 AS weight_group, COUNT(*) AS patient_count
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- Task 33: Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
SELECT patient_id, weight, height,
  CASE
    WHEN (weight / POWER(height / 100, 2)) >= 30 THEN 1
    ELSE 0
  END AS isObese
FROM patients;

-- Task 34: Show patient_id, first_name, last_name, and attending doctor's specialty.Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, 
--and doctors tables for required information.
SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';


-- Task 35: All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
SELECT patient_id,
       CONCAT(
           patient_id,
           LENGTH(last_name),
           YEAR(birth_date)
       ) AS temp_password
FROM patients
WHERE patient_id IN (
    SELECT DISTINCT patient_id
    FROM admissions
);

-- Task 2: Patients with no recorded allergies
SELECT first_name, last_name, gender
FROM patients
WHERE allergies is NULL;


-- Task 3: First names starting with 'C'
select first_name
from patients
where first_name like 'c';


-- Task 4: Patients with weight between 100 and 120 kg
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 and 120;


-- Task 5: Replace NULL allergies with 'NKA'(No Known Allergies)
-- Note: UPDATE not executed due to read-only access on remote DB.
/* update patients
   set allergies = 'NKA'
   where allergies is nul;
   select first_name, allergies from patients;*/ 



-- Task 6: Show full names (first + last)
-- CONCATENATE function is used to combine first and last names
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;


-- Task 7: First name, last name, and full province name
select p.first_name, p.last_name, pn.province_name
from patients p
join province_names pn ON p.province_id = pn.province_id;


-- Task 8: Count patients born in 2010
select count(*) as total_patioents_2010
from patients
where year(birth_date) = 2010;


-- Task 9: Patient with the greatest height
select first_name, last_name, height
from patients
where height = (select max(height) from patients); -- order by height desc limit 1;


-- Task 10: 5 lightest patients by weight
select first_name, last_name, weight
from patients
order by weight asc limit 5;