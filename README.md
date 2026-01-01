# CRM-sale-and-opportunity-project
Project Overview

This project analyzes a fictional CRM Sales & Opportunities dataset (Kaggle) using SQL to derive business-ready insights around revenue, sales performance, customer value, and pipeline risk. The goal is to demonstrate real-world SQL skills used by Data Analysts in CRM, Sales Ops, and Business Analytics roles.

 Business Objectives

Identify high-value and repeat customers
Analyze sales rep and team performance
Detect at-risk opportunities in the pipeline
Understand industry-wise revenue contribution
Calculate Customer Lifetime Value (CLV) for retention strategy

 Dataset

Source: Kaggle – CRM Sales & Opportunities Dataset (fictional)
Core Tables Used:
accounts – customer/company details (account, account_name, industry, etc.)
sales_pipeline – opportunities and deal data (opportunity_id, account, deal_size, sales_stage, created_date)
sales_teams – sales reps and teams (sales_agent, sales_rep, sales_team)

 Tools & Technologies

SQL (MySQL / PostgreSQL compatible)
Excel (optional: data inspection)



 SQL Concepts Demonstrated

--SELECT, WHERE, ORDER BY, DISTINCT
--Aggregations: SUM, AVG, COUNT
-- BY, HAVING
--JOIN (INNER, LEFT)
--Subqueries
--CASE WHEN
--Date functions (DATEDIFF, CURRENT_DATE)
--Window Functions: RANK(), PARTITION BY
--Views (for dynamic metrics like risk status)

 Key Analyses & Questions Answered
1. Sales & Revenue
Total and average deal size
Top 3 industries by total revenue
Industry-wise and customer-wise revenue contribution

2.Customer Analytics
High-value repeat customers (multiple deals + above-average revenue)
Inactive customers (no deals in the last 12 months)
Customer Lifetime Value (CLV) using:
CLV = Average Deal Value × Number of Deals

3.Sales Performance
Rank customers by total revenue
Rank sales reps within each team using window functions
Identify top deal per industry

4.Pipeline Health
Classify opportunities as Won / Lost / In Progress
Identify at-risk deals based on deal age and stage
Create a dynamic view to track risk status
