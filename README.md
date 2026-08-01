# ☕ Coffee Shop Sales Analysis — SQL, Excel & Power BI

A portfolio project analyzing a full year (2024) of point-of-sale transactions for a
3-location coffee shop chain, covering data cleaning, SQL analysis, and an Excel dashboard.

## 📁 Repo Contents
| File / Folder | Description |
|---|---|
| [`data/coffee_shop_sales.csv`](data/coffee_shop_sales.csv) | Raw transaction-level dataset (~6,900 rows) |
| [`sql/coffee_shop_analysis.sql`](sql/coffee_shop_analysis.sql) | KPI, trend, and ranking queries |
| [`excel/Coffee_Shop_Sales_Dashboard.xlsx`](excel/Coffee_Shop_Sales_Dashboard.xlsx) | **Excel dashboard** — live formulas + charts |

## 📊 Live Dashboard Links
- **Excel Dashboard:** [`excel/Coffee_Shop_Sales_Dashboard.xlsx`](excel/Coffee_Shop_Sales_Dashboard.xlsx)

## Project Overview
This project simulates the role of a data analyst supporting a growing coffee shop
chain. The objective is to evaluate business performance across three store
locations (Downtown, Riverside, Uptown Mall) and surface insights that could guide
staffing, inventory, and menu decisions.

**Dataset:** Synthetic 2024 transaction data (transaction id, date, time, store
location, product category/type, unit price, quantity, total sales), generated to
mirror the structure of a real POS export.

## Problem Statement
Examine key indicators in the sales data to understand business performance and
surface trends in product demand, peak trading hours, and store-level performance —
then visualize those findings in Excel and Power BI dashboards for non-technical
stakeholders.

## Analysis
Metrics calculated (see [`sql/coffee_shop_analysis.sql`](sql/coffee_shop_analysis.sql)):
- **Total Revenue** — sum of all transaction totals
- **Total Orders** and **Total Items Sold**
- **Average Order Value** and **Average Items per Order**
- **Revenue by Product Category** (Coffee, Tea, Bakery, Merchandise)
- **Top & Bottom Sellers** by units sold and revenue
- **Daily / Hourly / Day-of-Week Trends** to identify peak trading periods
- **Revenue by Store Location** with month-over-month growth

## Project Phases
**1. Data Acquisition & SQL**
Loaded the raw CSV into a relational table and used SQL (window functions, CTEs,
`SUMIFS`-style aggregation) to compute the KPIs above.

**2. Excel Dashboard**
Built an interactive workbook (`excel/Coffee_Shop_Sales_Dashboard.xlsx`) with a
`Raw Data` sheet feeding a `Dashboard` sheet driven entirely by live `SUMIF`/
`SUMPRODUCT` formulas — KPI cards, revenue-by-category and revenue-by-location
tables, a monthly trend table, and bar/line charts.

## Tech Stack
`SQL` · `Microsoft Excel` (SUMIF/SUMPRODUCT formulas, PivotChart-style dashboard) ·

## Getting Started
```bash
git clone <your-repo-url>
cd coffee-shop-sales-analysis
```
1. Open `excel/Coffee_Shop_Sales_Dashboard.xlsx` to explore the live dashboard
2. Run the queries in `sql/coffee_shop_analysis.sql` against `data/coffee_shop_sales.csv`
   (loaded into MySQL/SQL Server/Postgres)

## Conclusion
This project demonstrates end-to-end analytics skills — from raw transactional data
to SQL-driven insight extraction to polished, stakeholder-ready dashboards in both
Excel and Power BI.
