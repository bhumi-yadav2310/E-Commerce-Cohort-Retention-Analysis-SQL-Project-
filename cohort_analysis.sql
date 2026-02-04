-- ==========================================================
-- FILE: 03_cohort_analysis.sql
-- PHASE: Cohort & Retention Analysis
-- ==========================================================

-- Step 1: Find first purchase month for each customer (cohort month)
CREATE VIEW customer_first_purchase AS
SELECT 
    CustomerID,
    MIN(DATE_TRUNC('month', InvoiceDate)) AS first_purchase_month
FROM online_retail_final
GROUP BY CustomerID;

-- Step 2: Assign cohort month to all transactions
CREATE VIEW transactions_with_cohort AS
SELECT 
    o.CustomerID,
    DATE_TRUNC('month', o.InvoiceDate) AS transaction_month,
    c.first_purchase_month AS cohort_month,
    o.Quantity,
    o.Price
FROM online_retail_final o
JOIN customer_first_purchase c
ON o.CustomerID = c.CustomerID;

-- Step 3: Cohort size (number of unique customers in each cohort)
SELECT 
    cohort_month,
    COUNT(DISTINCT CustomerID) AS cohort_size
FROM transactions_with_cohort
GROUP BY cohort_month
ORDER BY cohort_month;

-- Step 4: Retention table (how many customers return each month)
SELECT 
    cohort_month,
    transaction_month,
    COUNT(DISTINCT CustomerID) AS retained_customers,
    COUNT(DISTINCT CustomerID)::float / 
        (SELECT COUNT(*) 
         FROM customer_first_purchase 
         WHERE first_purchase_month = t.cohort_month) AS retention_rate
FROM transactions_with_cohort t
GROUP BY cohort_month, transaction_month
ORDER BY cohort_month, transaction_month;