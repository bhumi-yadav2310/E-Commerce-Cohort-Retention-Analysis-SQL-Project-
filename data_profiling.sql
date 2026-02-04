-- ==========================================================
-- FILE: 01_profiling.sql
-- PHASE: Data Profiling
-- ==========================================================

-- Total rows
SELECT 
	COUNT(*) AS total_rows 
FROM online_retail;

-- Total customers
SELECT
	COUNT(DISTINCT CustomerID) AS total_customers 
FROM online_retail;

-- Missing values
SELECT 
    SUM(CASE
			WHEN CustomerID IS NULL THEN 1
			ELSE 0 
		END) AS missing_customer,
    SUM(CASE
		WHEN Invoice IS NULL THEN 1 
		ELSE 0
	END) AS missing_invoice,
    SUM(CASE 
		WHEN Quantity <= 0 THEN 1 
		ELSE 0 
	END) AS negative_or_zero_qty,
    SUM(CASE 
		WHEN Price <= 0 THEN 1
		ELSE 0
	END) AS negative_or_zero_price
FROM online_retail;

-- Duplicate transactions
SELECT 
	Invoice,
	StockCode,
	COUNT(*) AS duplicate_count
FROM online_retail
GROUP BY Invoice, StockCode
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC
LIMIT 10;

-- Total distinct products
SELECT 
	COUNT(DISTINCT StockCode) AS total_products
FROM online_retail;

-- Top 10 transactions by revenue
SELECT 
	Invoice,
	SUM(Quantity * Price) AS transaction_total
FROM online_retail
GROUP BY Invoice
ORDER BY transaction_total DESC
LIMIT 10;