/* =========================================================
   Project Title : Blinkit Grocery Sales Data Analysis
   Author        : Lidiya Mitiku
   Description   : End-to-end SQL analysis including
                   data cleaning, KPIs, joins, views,
                   subqueries, and indexing.
========================================================= */

-- =========================================================
-- NOTE:
-- Run this script in your SQL environment where
-- Blinkit tables are already imported.
-- No database creation or USE statement included.
-- =========================================================

-- =========================================================
-- SECTION 1: VIEW RAW DATA
-- =========================================================
SELECT *
FROM [blinkit grocery data];

-- =========================================================
-- SECTION 2: DATA CLEANING
-- Standardize Item Fat Content
-- =========================================================
UPDATE [blinkit grocery data]
SET Item_Fat_Content =
CASE
    WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
    WHEN Item_Fat_Content = 'REG' THEN 'Regular'
    ELSE Item_Fat_Content
END;

-- Validate cleaning
SELECT DISTINCT Item_Fat_Content
FROM [blinkit grocery data];

-- =========================================================
-- SECTION 3: KPI CALCULATIONS
-- =========================================================

-- Total Sales (Raw)
SELECT SUM(Sales) AS Total_Sales
FROM [blinkit grocery data];

-- Total Sales (in Millions)
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM [blinkit grocery data];

-- Average Sales
SELECT CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales
FROM [blinkit grocery data];

-- Number of Items Sold
SELECT COUNT(*) AS Number_of_Items
FROM [blinkit grocery data];

-- Average Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM [blinkit grocery data];

-- =========================================================
-- SECTION 4: BUSINESS ANALYSIS
-- =========================================================

-- Sales by Fat Content
SELECT
    Item_Fat_Content,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales,
    COUNT(*) AS Number_of_Items,
    AVG(Rating) AS Avg_Rating
FROM [blinkit grocery data]
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

-- Sales by Item Type
SELECT
    Item_Type,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales,
    COUNT(*) AS Number_of_Items,
    AVG(Rating) AS Avg_Rating
FROM [blinkit grocery data]
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- Sales by Outlet Establishment Year
SELECT
    Outlet_Establishment_Year,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales,
    COUNT(*) AS Number_of_Items,
    AVG(Rating) AS Avg_Rating
FROM [blinkit grocery data]
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;

-- Sales by Outlet Location Type
SELECT
    Outlet_Location_Type,
    SUM(Sales) AS Total_Sales
FROM [blinkit grocery data]
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- Sales by Outlet Type
SELECT
    Outlet_Type,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales,
    COUNT(*) AS Number_of_Items,
    AVG(Rating) AS Avg_Rating
FROM [blinkit grocery data]
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

-- =========================================================
-- SECTION 5: OUTLET DIMENSION TABLE CREATION
-- =========================================================
DROP TABLE IF EXISTS outlet_data;

SELECT DISTINCT
    Outlet_Identifier,
    Outlet_Establishment_Year,
    Outlet_Location_Type,
    Outlet_Size,
    Outlet_Type
INTO outlet_data
FROM [blinkit grocery data];

-- =========================================================
-- SECTION 6: MASTER DATA MODEL (JOIN)
-- =========================================================
SELECT TOP 20
    b.Item_Identifier,
    b.Item_Type,
    b.Item_Fat_Content,
    b.Item_Weight,
    b.Sales,
    b.Rating,
    o.Outlet_Identifier,
    o.Outlet_Location_Type,
    o.Outlet_Size,
    o.Outlet_Type,
    o.Outlet_Establishment_Year
FROM [blinkit grocery data] b
JOIN outlet_data o
    ON b.Outlet_Identifier = o.Outlet_Identifier;

-- =========================================================
-- SECTION 7: ANALYTICAL QUERIES (JOINS)
-- =========================================================

-- Sales by Outlet Type
SELECT
    o.Outlet_Type,
    SUM(b.Sales) AS Total_Sales
FROM [blinkit grocery data] b
JOIN outlet_data o
    ON b.Outlet_Identifier = o.Outlet_Identifier
GROUP BY o.Outlet_Type
ORDER BY Total_Sales DESC;

-- Sales by Outlet Size
SELECT
    o.Outlet_Size,
    SUM(b.Sales) AS Total_Sales,
    AVG(b.Rating) AS Avg_Rating
FROM [blinkit grocery data] b
JOIN outlet_data o
    ON b.Outlet_Identifier = o.Outlet_Identifier
GROUP BY o.Outlet_Size
ORDER BY Total_Sales DESC;

-- Sales by Location Type
SELECT
    o.Outlet_Location_Type,
    SUM(b.Sales) AS Total_Sales,
    COUNT(*) AS Total_Items
FROM [blinkit grocery data] b
JOIN outlet_data o
    ON b.Outlet_Identifier = o.Outlet_Identifier
GROUP BY o.Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- Item Type Performance
SELECT
    b.Item_Type,
    SUM(b.Sales) AS Total_Sales,
    AVG(b.Rating) AS Avg_Rating
FROM [blinkit grocery data] b
GROUP BY b.Item_Type
ORDER BY Total_Sales DESC;

-- Outlet Age vs Sales
SELECT
    o.Outlet_Establishment_Year,
    SUM(b.Sales) AS Total_Sales
FROM [blinkit grocery data] b
JOIN outlet_data o
    ON b.Outlet_Identifier = o.Outlet_Identifier
GROUP BY o.Outlet_Establishment_Year
ORDER BY o.Outlet_Establishment_Year;

-- =========================================================
-- SECTION 8: SUBQUERY ANALYSIS
-- =========================================================
SELECT
    Item_Identifier,
    Item_Type,
    Sales
FROM [blinkit grocery data]
WHERE Sales > (
    SELECT AVG(Sales)
    FROM [blinkit grocery data]
);

-- =========================================================
-- SECTION 9: VIEW CREATION
-- =========================================================
CREATE VIEW vw_sales_summary AS
SELECT
    Item_Type,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Avg_Sales
FROM [blinkit grocery data]
GROUP BY Item_Type;

-- View output
SELECT * FROM vw_sales_summary;

-- =========================================================
-- SECTION 10: INDEXING
-- =========================================================
CREATE INDEX idx_outlet_identifier
ON [blinkit grocery data](Outlet_Identifier);