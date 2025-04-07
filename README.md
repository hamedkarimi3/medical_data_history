# 🩺 Medical Data History Project (Internship)

This project is part of an internship assignment to query and manage medical data using SQL, Docker, and optionally, cloud tools.

## 🚀 Features

- Local MySQL setup using Docker
- SQL tasks (35 queries) on patient, admission, doctor data
- Optional cloud setup for extended project (GCP / AWS)
- Git versioning and clean structure

## 🛠️ Tech Stack

- MySQL 8 (Dockerized)
- VS Code
- SQL Workbench / SQLTools
- Git & GitHub
- (Optional): BigQuery, Looker Studio, Power BI, AWS, Azure

## 🐳 Docker Setup

```bash
docker run -d --name med-sql -p 3307:3306 \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=project_medical_data_history \
  -e MYSQL_USER=dm_team4 \
  -e MYSQL_PASSWORD="DM!$!Team!47@4!23&" \
  mysql:8.0

## 🗃️ Folder Structure
medical_data_history/
├── Dockerfile
├── Tasks/
│   ├──Task2_sql_queries/query_01_to_35.sql....
│   └──Task1.txt
│
├── reports/
│   └── challenges_faced.md
│   
├── .gitignore
└── README.md
