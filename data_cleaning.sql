-- ==========================================================
-- FILE: 02_cleaning.sql
-- PHASE: Data Cleaning
-- ==========================================================

-- Step 1: Remove invalid rows
CREATE TABLE online_retail_clean AS
SELECT *
FROM online_retail
WHERE CustomerID IS NOT NULL
  AND Invoice IS NOT NULL
  AND Quantity > 0
  AND Price > 0;

-- Step 2: Remove exact duplicates
CREATE TABLE online_retail_final AS
SELECT DISTINCT *
FROM online_retail_clean;

-- Step 3: Check total rows after cleaning
SELECT 
	COUNT(*) AS total_clean_rows 
FROM online_retail_final;


SELECT COUNT(DISTINCT CustomerID) AS total_customers_clean
FROM online_retail_final;