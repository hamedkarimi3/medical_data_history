-- Task 1: Show first name, last name, and gender of male patients
SELECT
   first_name,
   last_name,
   gender
FROM
   patients
WHERE
   gender = 'M';

-- Task 2: Patients with no recorded allergies
SELECT
   first_name,
   last_name,
   gender
FROM
   patients
WHERE
   allergies is NULL;

-- Task 3: First names starting with 'C'
select
   first_name
from
   patients
where
   first_name like 'c';

-- Task 4: Patients with weight between 100 and 120 kg
SELECT
   first_name,
   last_name
FROM
   patients
WHERE
   weight BETWEEN 100 and 120;

-- Task 5: Replace NULL allergies with 'NKA'(No Known Allergies)
-- Note: UPDATE not executed due to read-only access on remote DB.
/* update patients
set allergies = 'NKA'
where allergies is nul;
select first_name, allergies from patients;*/
-- Task 6: Show full names (first + last)
-- CONCATENATE function is used to combine first and last names
SELECT
   CONCAT (first_name, ' ', last_name) AS full_name
FROM
   patients;

-- Task 7: First name, last name, and full province name
select
   p.first_name,
   p.last_name,
   pn.province_name
from
   patients p
   join province_names pn ON p.province_id = pn.province_id;

-- Task 8: Count patients born in 2010
select
   count(*) as total_patioents_2010
from
   patients
where
   year (birth_date) = 2010;

-- Task 9: Patient with the greatest height
select
   first_name,
   last_name,
   height
from
   patients
where
   height = (
      select
         max(height)
      from
         patients
   );

-- order by height desc limit 1;
-- Task 10: 5 lightest patients by weight
select
   first_name,
   last_name,
   weight
from
   patients
order by
   weight asc
limit
   5;