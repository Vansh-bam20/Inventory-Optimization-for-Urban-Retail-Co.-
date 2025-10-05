Solving Inventory Inefficiencies using SQL
A Data Analytics Project for Urban Retail Co.
Project Overview

Urban Retail Co. — a rapidly growing retail chain — faces challenges in maintaining optimal inventory levels across its physical stores and online platforms.
With thousands of SKUs, regional warehouses, and diverse product categories, inefficiencies such as stockouts, overstocking, and poor visibility have emerged.

This project demonstrates how SQL-based analytics can convert raw inventory and sales data into actionable insights, driving data-informed decisions and operational efficiency.

🎯 Objectives

The goal of this project is to design and implement a SQL-driven inventory monitoring and optimization solution that helps Urban Retail Co. achieve:

📉 Reduction in stockouts and overstocking

🧾 Real-time insights into SKU and supplier performance

⚙️ Smarter, data-backed inventory decisions

>> Improved profitability and customer satisfaction

Key Features & Deliverables
1. SQL Queries

A suite of optimized SQL queries was developed to perform:

Stock Level Calculations across stores and warehouses

Low Inventory Detection based on Reorder Thresholds

Reorder Point Estimation using historical sales trends

Inventory Turnover Analysis to assess product velocity

Summary Reports featuring key KPIs like:

Stockout Rate

Average Stock Level

Inventory Aging

2. Database Optimization

Instead of designing a schema, we used a single table for all the operations as it was going smoothly.

Implemented indexes, joins, and window functions for performance optimization

Created a clean, scalable, and well-documented SQL workflow

3. Analytical Insights

Using SQL outputs, several business insights and reports were generated:

Identification of fast-moving vs slow-moving products

Recommendations for stock adjustments to minimize holding costs

Evaluation of supplier performance and reliability

Forecasting demand trends based on seasonal/cyclical data

>> Business Impact

By implementing this SQL-based analytics system, Urban Retail Co. can:

Optimize inventory levels and supply chain operations

Reduce stockouts and excess inventory

Improve demand forecasting and replenishment accuracy

Enhance customer satisfaction and profitability

>> Technical Stack
Tool	Purpose
SQL	Data extraction, transformation, and analytics
MySQL / PostgreSQL	Database management
Excel / Power BI (optional)	Visualization of KPI summaries


Tables:

sales_transactions – records sales by SKU, store, and date

product_catalog – contains SKU details and categories

warehouse_inventory – tracks stock levels and movements

suppliers – supplier details and performance metrics

Each table is linked through foreign keys (SKU, supplier_id, store_id), ensuring referential integrity.

📈 Key Performance Indicators (KPIs)
KPI	Description
Stockout Rate	% of times a product was unavailable when demanded
Inventory Turnover	Frequency of inventory sold and replaced
Average Inventory Age	Time duration items remain in stock
Supplier Reliability Score	: Delivery consistency and lead time performance
📄 Project Deliverables

🗃️ SQL scripts with documentation

📊 Mocked or real KPI dashboard/report

📝 1–2 page Executive Summary outlining insights and business recommendations
