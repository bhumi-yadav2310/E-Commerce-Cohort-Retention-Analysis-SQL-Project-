-- ==========================================================
-- FILE: 04_revenue_repeat.sql
-- PHASE: Revenue & Repeat Purchase Analysis 
-- ==========================================================

-- Total revenue per cohort month
SELECT 
    cohort_month,
    ROUND(SUM(Quantity * Price), 2) AS total_revenue
FROM transactions_with_cohort
GROUP BY cohort_month
ORDER BY cohort_month;

--Average revenue per customer per cohort 
SELECT 
    cohort_month,
    ROUND(AVG(customer_revenue), 2) AS avg_revenue_per_customer
FROM (
    SELECT CustomerID, cohort_month, SUM(Quantity * Price) AS customer_revenue
    FROM transactions_with_cohort
    GROUP BY CustomerID, cohort_month
) AS sub
GROUP BY cohort_month
ORDER BY cohort_month;

-- Repeat purchase behavior: customers who purchased more than once
SELECT 
    cohort_month,
    COUNT(*) FILTER (WHERE purchase_count > 1) AS repeat_customers,
    COUNT(*) AS total_customers_in_cohort,
    ROUND(
        (COUNT(*) FILTER (WHERE purchase_count > 1)::numeric / COUNT(*)) , 2
    ) AS repeat_rate
FROM (
    SELECT CustomerID, cohort_month, COUNT(DISTINCT transaction_month) AS purchase_count
    FROM transactions_with_cohort
    GROUP BY CustomerID, cohort_month
) AS sub
GROUP BY cohort_month
ORDER BY cohort_month;

-- Top 10 highest revenue customers overall
SELECT CustomerID, ROUND(SUM(Quantity * Price), 2) AS total_revenue
FROM online_retail_final
GROUP BY CustomerID
ORDER BY total_revenue DESC
LIMIT 10;

-- ================= Extra Insights Queries =================

--  Average revenue per transaction per cohort
SELECT 
    cohort_month,
    ROUND(AVG(Quantity * Price), 2) AS avg_revenue_per_transaction
FROM transactions_with_cohort
GROUP BY cohort_month
ORDER BY cohort_month;

--  Month-over-month cohort revenue growth
SELECT 
    cohort_month,
    transaction_month,
    ROUND(SUM(Quantity * Price), 2) AS revenue,
    ROUND(SUM(Quantity * Price) - LAG(SUM(Quantity * Price)) OVER (PARTITION BY cohort_month ORDER BY transaction_month), 2) AS revenue_growth
FROM transactions_with_cohort
GROUP BY cohort_month, transaction_month
ORDER BY cohort_month, transaction_month;

-- Contribution of repeat customers to total revenue
WITH customer_purchases AS (
    SELECT 
        CustomerID,
        cohort_month,
        COUNT(DISTINCT transaction_month) AS purchase_count,
        SUM(Quantity * Price) AS total_spent
    FROM transactions_with_cohort
    GROUP BY CustomerID, cohort_month
)

SELECT 
    cohort_month,
    ROUND(SUM(total_spent) FILTER (WHERE purchase_count > 1), 2) AS repeat_customer_revenue,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(SUM(total_spent) FILTER (WHERE purchase_count > 1) / SUM(total_spent), 2) AS repeat_revenue_ratio
FROM customer_purchases
GROUP BY cohort_month
ORDER BY cohort_month;

--  Top 5 products per cohort
SELECT 
    t.cohort_month,
    o.StockCode,
    SUM(o.Quantity) AS total_sold,
    ROUND(SUM(o.Quantity * o.Price), 2) AS revenue
FROM transactions_with_cohort t
JOIN online_retail_final o 
  ON t.CustomerID = o.CustomerID 
  AND t.transaction_month = DATE_TRUNC('month', o.InvoiceDate)
GROUP BY t.cohort_month, o.StockCode
ORDER BY t.cohort_month, revenue DESC
LIMIT 5;