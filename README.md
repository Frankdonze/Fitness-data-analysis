Personal Finance Analysis Platform

Data Engineering MVP

Overview

This project is an end-to-end cloud-based data engineering pipeline for analyzing personal financial transaction data. It ingests raw financial records, cleans and structures them, stores them in analytics-ready formats, and enables SQL-based analysis and dashboarding.

The focus is on building a minimum viable product (MVP) that demonstrates core data engineering skills, including cloud infrastructure, ETL pipelines, data modeling, and analytical workflows.

Key Questions

How do spending patterns change over time?

How do different expense categories impact cash flow and savings?

How has overall financial health evolved over time?

Architecture

Raw Financial Files
→ Amazon S3 (Bronze – Raw Data)
→ Python ETL (EC2) - potentially move to lambda in future
→ Amazon S3 (Silver – Cleaned)
→ Amazon RDS (PostgreSQL – Gold Analytics Layer)
→ SQL Queries
→ Power BI Dashboards

Data Layers
Bronze (Raw)

Original financial transaction files (CSV, OFX, bank exports)

Stored in Amazon S3

Immutable and preserved for reprocessing

Silver (Cleaned)

Parsed and standardized transaction-level data

Normalized timestamps, currencies, and categories

Gold (Analytics)

Curated relational tables in PostgreSQL

Optimized for SQL queries and BI tools

Technologies Used

Cloud: AWS (S3, EC2, RDS, IAM)

Infrastructure as Code: Terraform

ETL / Processing: Python (pandas, pyarrow)

Storage Format: Parquet

Database: PostgreSQL (Amazon RDS)

Analytics: SQL

Visualization: Power BI

Version Control: Git & GitHub

ETL Workflow

Upload raw financial files to Amazon S3 (Bronze)

Process data with Python:

Normalize timestamps and currencies

Categorize transactions (income vs expenses)

Clean and validate records

Write cleaned data to Amazon S3 as Parquet (Silver)

Load analytics-ready tables into PostgreSQL (Gold)

Analytics & Insights

Example analyses include:

Spending trends by category

Income vs expense (cash flow) analysis

Savings rate over time

Long-term financial health indicators

Insights are queried using SQL and visualized using Power BI dashboards.

Infrastructure

All cloud infrastructure for this project is provisioned using Terraform and deployed on AWS.

AWS Resources

Amazon S3: Raw and cleaned data storage (Bronze and Silver layers)

Amazon RDS (PostgreSQL): Relational analytics database (Gold layer)

IAM Roles and Policies: Secure access between services

Terraform state files and credentials are excluded from version control to ensure security.
