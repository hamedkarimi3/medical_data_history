
### 📝 **Updated Report on Challenges Faced – Project_Medical_Data_History**

#### 1. **Understanding the Schema Relationships**
- One of the first challenges was understanding how the tables (`patients`, `admissions`, `doctors`, `province_names`, etc.) were connected.
- Correct joins were essential for getting accurate data, especially when involving indirect relationships such as linking a patient to a doctor through the `admissions` table.

#### 2. **Restricted SQL Permissions**
- While working with the database environment, we discovered that we **did not have sufficient permissions to perform `UPDATE` or `SET` operations**.
- This impacted tasks like **Task 5**, which required updating the `allergies` column where values were `NULL`.
- As a workaround, we could only write the correct SQL logic for such updates but couldn't execute them directly on the live server.

#### 3. **Handling NULL and Inconsistent Data**
- Many records had `NULL` values, particularly in columns like `allergies`, making it necessary to account for these in filtering and aggregation queries.
- Ensuring accurate counts and sorting required explicitly excluding or replacing NULLs in SELECT statements.

#### 4. **Date and String Manipulations**
- Tasks involving birth year extraction, length calculations, and full name formatting required careful usage of SQL functions like `YEAR()`, `LENGTH()`, `CONCAT()`, `UCASE()`, and `LCASE()`.
- Building temporary passwords that combined values across different data types (e.g., integers and string lengths) added complexity.

#### 5. **Grouping and Aggregation Logic**
- Some tasks required calculating values across grouped data (e.g., weight buckets, repeated diagnoses), using expressions like `FLOOR(weight / 10) * 10` and `HAVING COUNT(*) > 1`.
- These queries required not only aggregation but also conditional logic to isolate specific results.

#### 6. **Docker SQL Environment Setup**
- The setup of a containerized SQL environment via Docker was an initial technical hurdle.
- It required configuring environment variables, exposing the correct ports, and importing schema/data files properly.

---
