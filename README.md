📦 E-Commerce Customer Cohort & Retention Analysis (SQL Project)
##Executive Summary-
This project provides an end-to-end customer cohort and retention analysis for an e-commerce dataset using SQL only. It tracks customer behavior over time, identifies repeat buyers, measures revenue per cohort, and highlights top products. The analysis reveals key insights about customer loyalty, high-value segments, and actionable strategies to improve retention and maximize revenue.
##Project Overview-
This project analyzes customer behavior to understand retention, revenue patterns, and repeat purchase behavior. Advanced insights highlight high-value customers and top-selling products.
##Dataset Details:
i.Total transactions: 1,067,371
ii.Total unique customers: 59,402
iii.Columns: Invoice, CustomerID, InvoiceDate, Quantity, Price, StockCode
iv.Dataset source: Kaggle – Online Retail II
Dataset used in this project (~94 MB): Download from Kaggle-https://www.kaggle.com/datasets/mashlyn/online-retail-ii-uci
Phase 1 – Data Profiling:
Before performing any analysis, the dataset was explored to understand quality and identify issues:
i.Missing CustomerID: 2,43,007 rows → removed
ii.Negative or zero Quantity: 22,950 rows → removed
iii.Negative or zero Price: 6,225 rows → removed
iv.Total products: 5,305
##Observation:
The raw data contained missing or invalid values that could affect retention and revenue analysis. Cleaning was necessary to ensure accurate results.
Phase 2 – Data Cleaning
Steps taken to prepare the dataset:
i.Removed rows with missing CustomerID or Invoice.
ii.Removed rows with negative or zero Quantity or Price.
iii.Removed duplicate transactions.
iv.Created a clean table named online_retail_final for analysis.
##Result:
The cleaned dataset is now reliable for cohort, retention, and revenue analysis.
Phase 3 – Cohort & Retention Analysis
Each customer was assigned a cohort_month based on their first purchase, and retention was tracked over subsequent months.
##Key Insights:
-Early cohorts tend to have slightly lower retention than later cohorts.
-Retention drops significantly after three months, indicating opportunities for targeted retention campaigns.
Phase 4 – Revenue & Repeat Purchase Analysis
Core Observations:
-Total revenue per cohort ranges from approximately ₹50,000 to ₹1,250,000.
-Average revenue per customer per cohort ranges from ₹120 to ₹450.
-Repeat purchase rate: ~35% of customers made repeat purchases.
-Top 10 customers contributed ~12% of total revenue.
##Insights:
-A small number of loyal customers contribute disproportionately to revenue.
-Early detection of high-value cohorts can guide marketing strategies.
-Around 60% of revenue comes from repeat customers, highlighting the importance of loyal buyers.
##Additional Insights:
Some cohorts spend more per transaction even if their size is similar, highlighting high-value customers.
Revenue grows initially for some cohorts but may decline later, guiding marketing campaigns to boost retention.
Top-selling products per cohort provide insights for inventory management and targeted promotions.
Key Takeaways:
-Data cleaning is critical for accurate analysis.
-Cohort analysis reveals retention patterns and high-value segments.
-Repeat customers drive a significant portion of revenue.
-Extra insights provide actionable business intelligence for strategy.
##Conclusion & Recommendations
This analysis shows that a small percentage of loyal customers drive a significant portion of revenue, and retention drops after the first few months.
Recommendations:
-Implement targeted marketing campaigns for low-retention cohorts.
-Focus on high-value products and top customers for promotions.
-Encourage repeat purchases through loyalty programs or personalized offers.
-Monitor cohort performance over time to identify trends and adjust business strategies.
Overall: Cohort and revenue analysis provides actionable insights to grow customer lifetime value and improve overall business performance.
Project Structure
01_profiling.sql → Phase 1: Data profiling
02_cleaning.sql → Phase 2: Data cleaning
03_cohort_analysis.sql → Phase 3: Cohort & retention queries
04_revenue_repeat.sql → Phase 4: Revenue, repeat purchase, and extra insights
