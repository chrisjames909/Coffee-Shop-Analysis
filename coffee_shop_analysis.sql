/* ============================================================
   COFFEE SHOP SALES ANALYSIS - SQL QUERIES
   Dataset: coffee_shop_sales.csv (loaded into table coffee_sales)
   Engine: written for MySQL / SQL Server (T-SQL notes inline)
   ============================================================ */

-- 0. Table definition (run this first if loading raw CSV into a DB)
CREATE TABLE coffee_sales (
    transaction_id   INT PRIMARY KEY,
    transaction_date DATE,
    transaction_time TIME,
    store_location    VARCHAR(50),
    product_category  VARCHAR(50),
    product_type      VARCHAR(50),
    unit_price        DECIMAL(6,2),
    quantity          INT,
    total_sales       DECIMAL(8,2)
);

-- 1. Total Revenue
SELECT ROUND(SUM(total_sales), 2) AS total_revenue
FROM coffee_sales;

-- 2. Total Orders and Total Items Sold
SELECT
    COUNT(DISTINCT transaction_id) AS total_orders,
    SUM(quantity)                  AS total_items_sold
FROM coffee_sales;

-- 3. Average Order Value (AOV)
SELECT ROUND(SUM(total_sales) / COUNT(DISTINCT transaction_id), 2) AS avg_order_value
FROM coffee_sales;

-- 4. Average Items per Order
SELECT ROUND(SUM(quantity) * 1.0 / COUNT(DISTINCT transaction_id), 2) AS avg_items_per_order
FROM coffee_sales;

-- 5. Revenue by Product Category
SELECT
    product_category,
    ROUND(SUM(total_sales), 2) AS revenue,
    ROUND(100.0 * SUM(total_sales) / SUM(SUM(total_sales)) OVER (), 1) AS pct_of_total
FROM coffee_sales
GROUP BY product_category
ORDER BY revenue DESC;

-- 6. Top 10 Best-Selling Products (by quantity)
SELECT
    product_type,
    SUM(quantity)             AS units_sold,
    ROUND(SUM(total_sales),2) AS revenue
FROM coffee_sales
GROUP BY product_type
ORDER BY units_sold DESC
LIMIT 10;                       -- SQL Server: use TOP 10 in the SELECT clause instead

-- 7. Daily Sales Trend
SELECT
    transaction_date,
    COUNT(DISTINCT transaction_id) AS orders,
    ROUND(SUM(total_sales), 2)     AS revenue
FROM coffee_sales
GROUP BY transaction_date
ORDER BY transaction_date;

-- 8. Sales by Day of Week
SELECT
    DAYNAME(transaction_date)  AS day_of_week,     -- SQL Server: DATENAME(WEEKDAY, transaction_date)
    ROUND(SUM(total_sales),2)  AS revenue,
    COUNT(DISTINCT transaction_id) AS orders
FROM coffee_sales
GROUP BY DAYNAME(transaction_date)
ORDER BY revenue DESC;

-- 9. Hourly Sales Trend (peak hour analysis)
SELECT
    HOUR(transaction_time)     AS hour_of_day,     -- SQL Server: DATEPART(HOUR, transaction_time)
    COUNT(DISTINCT transaction_id) AS orders,
    ROUND(SUM(total_sales), 2) AS revenue
FROM coffee_sales
GROUP BY HOUR(transaction_time)
ORDER BY hour_of_day;

-- 10. Revenue by Store Location
SELECT
    store_location,
    ROUND(SUM(total_sales), 2) AS revenue,
    COUNT(DISTINCT transaction_id) AS orders,
    ROUND(SUM(total_sales) / COUNT(DISTINCT transaction_id), 2) AS avg_order_value
FROM coffee_sales
GROUP BY store_location
ORDER BY revenue DESC;

-- 11. Monthly Revenue Trend with Month-over-Month Growth
WITH monthly AS (
    SELECT
        DATE_FORMAT(transaction_date, '%Y-%m') AS sales_month,   -- SQL Server: FORMAT(transaction_date,'yyyy-MM')
        SUM(total_sales) AS revenue
    FROM coffee_sales
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY sales_month))
          / LAG(revenue) OVER (ORDER BY sales_month), 1) AS mom_growth_pct
FROM monthly
ORDER BY sales_month;

-- 12. Worst-Performing Products (bottom 5 by revenue) — candidates to retire
SELECT
    product_type,
    SUM(quantity)              AS units_sold,
    ROUND(SUM(total_sales), 2) AS revenue
FROM coffee_sales
GROUP BY product_type
ORDER BY revenue ASC
LIMIT 5;
