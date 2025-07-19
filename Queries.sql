Here are the SQL queries used to create dashboard :

---

**1. Total Sales**

```
SELECT SUM(Sales) AS Total_Sales FROM sales;
```

**2. Sales by Category**

```
SELECT Category, SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Category
ORDER BY Total_Sales DESC;
```

**3. Sales by Region**

```
SELECT Region, SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Region
ORDER BY Total_Sales DESC;
```

**4. Sales by Sub-Category**

```
SELECT [Sub-Category], SUM(Sales) AS Total_Sales
FROM sales
GROUP BY [Sub-Category]
ORDER BY Total_Sales DESC;
```

**5. Profit by Region**

```
SELECT Region, SUM(Profit) AS Total_Profit
FROM sales
GROUP BY Region
ORDER BY Total_Profit DESC;
```

**6. Monthly Sales Trend**

```
SELECT 
  STRFTIME('%Y-%m', [Order Date]) AS Month,
  SUM(Sales) AS Monthly_Sales
FROM sales
GROUP BY Month
ORDER BY Month;
```

**7. Sales and Profit by Segment**

```
SELECT Segment, SUM(Sales) AS Sales, SUM(Profit) AS Profit
FROM sales
GROUP BY Segment;
```

**8. Top 10 Customers by Sales**

```
SELECT [Customer Name], SUM(Sales) AS Total_Sales
FROM sales
GROUP BY [Customer Name]
ORDER BY Total_Sales DESC
LIMIT 10;
```

**9. Orders by Shipping Mode**

```
SELECT [Ship Mode], COUNT(DISTINCT [Order ID]) AS Total_Orders
FROM sales
GROUP BY [Ship Mode];
```

**10. Discount vs Profit Correlation**

```
SELECT Discount, AVG(Profit) AS Avg_Profit
FROM sales
GROUP BY Discount
ORDER BY Discount;
```


** 11. Repeat Customers**

```
SELECT [Customer Name], COUNT(DISTINCT [Order ID]) AS Order_Count
FROM sales
GROUP BY [Customer Name]
HAVING Order_Count > 1;
```

---

** 12. Top Selling Products **

```
SELECT [Product Name], SUM(Sales) AS Total_Sales
FROM sales
GROUP BY [Product Name]
ORDER BY Total_Sales DESC
LIMIT 10;
```

---

** 13. Negative Profit Orders **

```
SELECT [Order ID], [Product Name], Sales, Profit
FROM sales
WHERE Profit < 0
ORDER BY Profit;
```

---

** 14. Quarterly Sales **

```
SELECT 
  STRFTIME('%Y-Q'||((CAST(STRFTIME('%m', [Order Date]) AS INT)-1)/3 + 1), [Order Date]) AS Quarter,
  SUM(Sales) AS Quarterly_Sales
FROM sales
GROUP BY Quarter
ORDER BY Quarter;
```

---

** 15. Month-over-Month Sales Growth **

```
WITH Monthly_Sales AS (
  SELECT 
    STRFTIME('%Y-%m', [Order Date]) AS Month,
    SUM(Sales) AS Total_Sales
  FROM sales
  GROUP BY Month
)
SELECT 
  Month,
  Total_Sales,
  ROUND((Total_Sales - LAG(Total_Sales) OVER (ORDER BY Month)) * 100.0 / LAG(Total_Sales) OVER (ORDER BY Month), 2) AS MoM_Growth_Percent
FROM Monthly_Sales;
```

---

** 16. State-wise Performance **

```
SELECT State, SUM(Sales) AS Sales, SUM(Profit) AS Profit
FROM sales
GROUP BY State
ORDER BY Sales DESC;
```

---

** 17. Average Order Value by Segment **

```
SELECT Segment, ROUND(SUM(Sales) * 1.0 / COUNT(DISTINCT [Order ID]), 2) AS Avg_Order_Value
FROM sales
GROUP BY Segment;
```

---

** 18. Average Shipping Delay **

```
SELECT 
  AVG(JULIANDAY([Ship Date]) - JULIANDAY([Order Date])) AS Avg_Shipping_Days
FROM sales;
```

---

** 19. Sales by Discount Buckets **

```
SELECT 
  CASE 
    WHEN Discount = 0 THEN 'No Discount'
    WHEN Discount > 0 AND Discount <= 0.2 THEN 'Low Discount'
    WHEN Discount > 0.2 AND Discount <= 0.4 THEN 'Medium Discount'
    ELSE 'High Discount'
  END AS Discount_Category,
  SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Discount_Category;
```

---

** 20. Return Ratio by Category (if return column exists) **

```
SELECT 
  Category,
  COUNT(CASE WHEN Returned = 'Yes' THEN 1 END)*1.0 / COUNT(*) AS Return_Rate
FROM sales
GROUP BY Category;
```

