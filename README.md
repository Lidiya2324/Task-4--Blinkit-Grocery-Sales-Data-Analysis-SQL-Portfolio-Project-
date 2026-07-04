# 📊 Task 4 Blinkit Grocery Sales Data Analysis (SQL Portfolio Project)

## 🧾 Project Overview

This project presents an end-to-end SQL analysis of Blinkit grocery sales data.  
The goal is to analyze sales performance, customer behavior, and outlet-level trends to generate actionable business insights.

The project includes:
- Data cleaning and standardization  
- KPI calculations  
- Business performance analysis  
- Data modeling using SQL JOINs  
- Advanced SQL features (views, subqueries, indexing)

---

## 🛠️ Tools & Technologies

- SQL Server  
- MySQL-style SQL logic  
- Excel (Data Source)  
- GitHub (Version Control & Documentation)

---

## 🎯 Business Objectives

- Analyze overall sales performance  
- Identify top-performing product categories  
- Evaluate outlet performance (type, size, location)  
- Understand customer ratings and trends  
- Build relational data model using SQL JOINs  

---

## 📂 Dataset Description

The dataset contains grocery sales data including:

- Item details (type, fat content, weight, visibility)  
- Sales and rating information  
- Outlet attributes (type, size, location, establishment year)  
- Outlet identifiers for relational mapping  

---

## 🧹 Data Cleaning

- Standardized `Item_Fat_Content` values:
  - LF → Low Fat  
  - low fat → Low Fat  
  - REG → Regular  
- Ensured consistency across categorical fields  
- Prepared dataset for analysis and modeling  

---

## 📊 Key Performance Indicators (KPIs)

### 🔹 Total Sales (in Millions)

SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM [blinkit grocery data];


---

### 🔹 Average Sales

SELECT CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales
FROM [blinkit grocery data];

---

### 🔹 Number of Items Sold

SELECT COUNT(*) AS Number_of_Items
FROM [blinkit grocery data];

---

### 🔹 Average Rating

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM [blinkit grocery data];

---

## 📈 Business Analysis

### 📦 Sales Performance
- Sales by item type  
- Sales by fat content  
- Sales by outlet type  

### 🏬 Outlet Analysis
- Outlet size vs sales performance  
- Outlet location impact  
- Outlet establishment year trends  

### ⭐ Customer Analysis
- Average rating by category  
- Rating distribution across outlets  

---

## 🔗 Data Model (SQL JOINs)

A relational model was created using:

- Fact Table: blinkit grocery data  
- Dimension Table: outlet_data  

---

### 🔗 Master JOIN Query

SELECT TOP 20
    b.Item_Identifier,
    b.Item_Type,
    b.Sales,
    b.Rating,
    o.Outlet_Type,
    o.Outlet_Size,
    o.Outlet_Location_Type
FROM [blinkit grocery data] b
JOIN outlet_data o
ON b.Outlet_Identifier = o.Outlet_Identifier;

---

## 📊 Advanced SQL Features Used

- INNER JOIN  
- GROUP BY aggregations  
- Subqueries  
- Views  
- Indexing  

---

## 💡 Key Insights

- Medium-sized outlets contribute significantly to total revenue  
- Certain item types dominate overall sales  
- Outlet type strongly impacts performance  
- Location plays a key role in sales variation  
- Data modeling improves analysis efficiency  

---

## 📸 Screenshots

Place all screenshots inside a folder named:

/screenshots

### Required Screenshots:

- 01_tables.png → Database and tables view  
- 02_sales_data.png → Sample raw data  
- 03_outlet_data.png → Outlet table  
- 04_join_output.png → Master JOIN result  
- 05_kpi_results.png → KPI outputs  
- 06_sales_analysis.png → Business insights  

---

## 📁 Project Structure

Blinkit-SQL-Project/
│
├── Blinkit_SQL_Project.sql
├── README.md
│
├── screenshots/
│   ├── 01_tables.png
│   ├── 02_sales_data.png
│   ├── 03_outlet_data.png
│   ├── 04_join_output.png
│   ├── 05_kpi_results.png
│   └── 06_sales_analysis.png
│
└── data/
    └── blinkit_dataset.csv

---

## 🚀 How to Run This Project

1. Import dataset into SQL Server  
2. Run the SQL script  
3. Execute analysis queries  
4. Review insights

Note: Some fields in the original dataset contain missing (NULL) values. These were retained because they did not affect the objectives of this SQL analysis.

---

## 👩‍💻 Author

**Lidiya Mitiku**  
📧 Email: Lidu2324@gmail.com  
🔗 GitHub: https://github.com/Lidiya2324  
🔗 LinkedIn: https://www.linkedin.com/in/lidiya-mitiku-10b816189/

---

## ⭐ Future Improvements

- Power BI dashboard  
- Python data analysis  
- Forecasting model  
- Automated reporting pipeline  

---

## 📌 Final Note

This project demonstrates end-to-end SQL skills including data cleaning, data modeling, and business insight generation.)
