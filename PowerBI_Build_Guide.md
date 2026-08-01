# Power BI Dashboard — Build Guide (Coffee Shop Sales)

> **Note:** A `.pbix` file is a binary format produced by Power BI Desktop, which isn't
> available in this environment, so it can't be generated directly here. This guide
> plus the DAX measures below let you build the exact same dashboard in Power BI
> Desktop in about 10 minutes, then commit the resulting `.pbix` to this repo.

## 1. Get the data in
1. Open Power BI Desktop → **Get Data** → **Text/CSV**
2. Load `data/coffee_shop_sales.csv`
3. In Power Query, set data types: `transaction_date` → Date, `transaction_time` → Time,
   `unit_price`/`total_sales` → Decimal Number, `quantity` → Whole Number
4. Close & Apply

## 2. Create a Date table
Model view → **New Table**:
```dax
DateTable = CALENDAR(MIN(coffee_shop_sales[transaction_date]), MAX(coffee_shop_sales[transaction_date]))
```
Mark it as a Date table, then relate `DateTable[Date]` → `coffee_shop_sales[transaction_date]`.

## 3. DAX Measures
```dax
Total Revenue = SUM(coffee_shop_sales[total_sales])

Total Orders = DISTINCTCOUNT(coffee_shop_sales[transaction_id])

Total Items Sold = SUM(coffee_shop_sales[quantity])

Average Order Value = DIVIDE([Total Revenue], [Total Orders])

Average Items per Order = DIVIDE([Total Items Sold], [Total Orders])

Revenue MoM % = 
VAR CurrMonth = [Total Revenue]
VAR PrevMonth = CALCULATE([Total Revenue], DATEADD(DateTable[Date], -1, MONTH))
RETURN DIVIDE(CurrMonth - PrevMonth, PrevMonth)
```

## 4. Pages to build
- **Overview**: KPI cards (Total Revenue, Total Orders, AOV, Items Sold) + line chart of
  daily/monthly revenue trend + slicer for `store_location`
- **Product Performance**: bar chart of Revenue by `product_category`, table of top
  products by `product_type` sorted by revenue
- **Time Analysis**: matrix of Revenue by day-of-week × hour-of-day (heat map), useful
  for staffing decisions
- **Store Comparison**: clustered bar chart of Revenue/AOV by `store_location`

## 5. Publish & link back
Once built, save as `powerbi/Coffee_Shop_Sales_Report.pbix` in this folder, commit it,
and it will be reachable from the repo at:

`powerbi/Coffee_Shop_Sales_Report.pbix`

If you publish it to the Power BI Service, add the sharable report link in `README.md`
under **Live Dashboard Links**.
