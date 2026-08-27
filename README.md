# 🛍️ Retail Sales Analysis Using SQL

## 📌 Project Overview

This project focuses on analyzing retail sales data using **SQL**. The goal is to explore the dataset, clean missing values, and answer important business questions related to sales, customers, product categories, and purchasing behavior.

The project demonstrates practical SQL skills commonly used by Data Analysts, including:

- Data Exploration
- Data Cleaning
- Aggregate Functions
- Filtering with `WHERE`
- Grouping with `GROUP BY`
- Conditional Logic with `CASE`
- Date and Time Functions
- Window Functions
- Customer and Sales Analysis

---

# 🎯 Project Objectives

The main objectives of this project are:

1. Analyze the total number of sales transactions.
2. Identify the number of unique customers.
3. Analyze sales for specific dates.
4. Identify high-quantity product transactions.
5. Calculate sales performance by category.
6. Analyze customer demographics.
7. Identify high-value transactions.
8. Compare transactions by gender and category.
9. Find the best-selling months.
10. Identify top customers based on total spending.
11. Analyze customer distribution across categories.
12. Classify sales into Morning, Afternoon, and Evening shifts.

---

# 🛠️ Tools & Technologies

- SQL
- PostgreSQL / SQL-compatible database
- GitHub
- CSV Dataset

---

# 📂 Dataset

The dataset contains retail transaction information with the following columns:

| Column Name | Description |
|---|---|
| `transactions_id` | Unique ID for each transaction |
| `sale_date` | Date of the sale |
| `sale_time` | Time of the sale |
| `customer_id` | Unique customer ID |
| `gender` | Customer gender |
| `age` | Customer age |
| `category` | Product category |
| `quantiy` | Quantity of products purchased |
| `price_per_unit` | Price of one product unit |
| `cogs` | Cost of Goods Sold |
| `total_sale` | Total transaction amount |

---

# 🧮 Important Business Formulas

## 1. Total Sales

**Formula:**

```text
Total Sales = SUM(total_sale)
```

```sql
SUM(total_sale)
```

## 2. Total Number of Transactions

```text
Total Transactions = COUNT(*)
```

```sql
COUNT(*)
```

## 3. Unique Customers

```text
Unique Customers = COUNT(DISTINCT customer_id)
```

```sql
COUNT(DISTINCT customer_id)
```

## 4. Average Age

```text
Average Age = SUM(Age) / Number of Customers
```

```sql
AVG(age)
```

---

# 🧹 Data Cleaning

Before performing analysis, missing values should be handled to ensure reliable results.

```sql
SELECT transactions_id, sale_date, sale_time, customer_id, gender, age, category,
COALESCE(quantiy, 0) AS quantiy,
COALESCE(price_per_unit, 0) AS price_per_unit,
COALESCE(cogs, 0) AS cogs,
COALESCE(total_sale, 0) AS total_sale
FROM Retail_Sales_Analysis;
```

**Logic:**

```text
If Value is NULL → Replace it with 0
```

---

# 📊 Business Questions and SQL Answers

## Q1. How many sales do we have?

### Formula

```text
Total Sales Transactions = COUNT(*)
```

### SQL Query

```sql
SELECT COUNT(*) AS total_sales
FROM Retail_Sales_Analysis;
```

**Explanation:** `COUNT(*)` counts every row in the table. Each row represents one sales transaction.

---

## Q2. How many unique customers do we have?

### Formula

```text
Unique Customers = COUNT(DISTINCT customer_id)
```

### SQL Query

```sql
SELECT COUNT(DISTINCT customer_id) AS number_of_customer
FROM Retail_Sales_Analysis;
```

**Explanation:** `DISTINCT` removes duplicate customer IDs before counting.

---

## Q3. Retrieve all sales made on `2022-11-05`

```sql
SELECT *
FROM Retail_Sales_Analysis
WHERE sale_date = '2022-11-05';
```

**Logic:**

```text
Return transaction
WHERE sale_date = 2022-11-05
```

---

## Q4. Find Clothing transactions where quantity is greater than 3 during November 2022

### Conditions

```text
Category = Clothing
AND
Quantity > 3
AND
Sale Date is between 2022-11-01 and 2022-11-30
```

```sql
SELECT *
FROM Retail_Sales_Analysis
WHERE category = 'Clothing'
  AND quantiy > 3
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
ORDER BY sale_date ASC;
```

---

## Q5. Calculate total sales for each category

### Formula

```text
Category Sales = SUM(total_sale)
```

```sql
SELECT
    category,
    SUM(total_sale) AS sale_per_category,
    COUNT(total_sale) AS no_of_orders
FROM Retail_Sales_Analysis
GROUP BY category;
```

**Formula used:**

```text
Total Revenue = SUM(total_sale)
Number of Orders = COUNT(total_sale)
```

---

## Q6. Find the average age of customers who purchased Beauty products

### Formula

```text
Average Age = SUM(age) / Number of Customers
```

```sql
SELECT
    ROUND(AVG(age), 2) AS avg_age
FROM Retail_Sales_Analysis
WHERE category = 'Beauty';
```

---

## Q7. Find all transactions where total sales are greater than 1000

### Condition

```text
total_sale > 1000
```

```sql
SELECT *
FROM Retail_Sales_Analysis
WHERE total_sale > 1000;
```

---

## Q8. Find the total number of transactions by gender and category

### Formula

```text
Number of Transactions = COUNT(transactions_id)
```

```sql
SELECT
    gender,
    category,
    COUNT(transactions_id) AS total_no_of_transactions
FROM Retail_Sales_Analysis
GROUP BY gender, category;
```

---

## Q9. Find the average sale for each month and identify the best-selling month in each year

### Formula

```text
Average Monthly Sale = SUM(total_sale) / Number of Transactions
```

SQL implementation:

```sql
AVG(total_sale)
```

```sql
WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM Retail_Sales_Analysis
    GROUP BY
        EXTRACT(YEAR FROM sale_date),
        EXTRACT(MONTH FROM sale_date)
),
ranked_sales AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY year
            ORDER BY avg_sale DESC
        ) AS sales_rank
    FROM monthly_sales
)
SELECT *
FROM ranked_sales
WHERE sales_rank = 1
ORDER BY year;
```

**Logic:**

```text
PARTITION BY Year → Separate results for each year
ORDER BY avg_sale DESC → Highest average sale comes first
RANK() = 1 → Best-selling month
```

---

## Q10. Find the top 5 customers based on highest total sales

### Formula

```text
Customer Total Spending = SUM(total_sale)
```

```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sale
FROM Retail_Sales_Analysis
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

---

## Q11. Find the number of unique customers who purchased from each category

### Formula

```text
Unique Customers per Category = COUNT(DISTINCT customer_id)
```

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_cx
FROM Retail_Sales_Analysis
GROUP BY category;
```

---

## Q12. Create sales shifts and count the number of orders

### Shift Logic

| Shift | Time |
|---|---|
| Morning | Before 12:00 |
| Afternoon | 12:00 to 17:00 |
| Evening | After 17:00 |

```sql
WITH shift_sales AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Retail_Sales_Analysis
)
SELECT
    shift,
    COUNT(*) AS total_orders
FROM shift_sales
GROUP BY shift
ORDER BY total_orders DESC;
```

### Formula

```text
Orders per Shift = COUNT(*)
```

---

# 📈 SQL Concepts Used

| SQL Concept | Usage |
|---|---|
| `SELECT` | Retrieve data |
| `WHERE` | Filter records |
| `COUNT()` | Count transactions |
| `SUM()` | Calculate total sales |
| `AVG()` | Calculate averages |
| `DISTINCT` | Find unique values |
| `GROUP BY` | Group similar records |
| `ORDER BY` | Sort results |
| `LIMIT` | Restrict number of results |
| `BETWEEN` | Filter a range |
| `CASE` | Create conditional categories |
| `COALESCE()` | Handle null values |
| `EXTRACT()` | Extract year, month, or hour |
| `RANK()` | Rank records using a window function |
| `CTE` | Create temporary query results |

---

# 💡 Key Business Insights

This analysis helps answer important business questions such as:

- How many transactions were made?
- How many unique customers purchased products?
- Which product categories generate the highest sales?
- Which customers spend the most?
- Which months perform best?
- Which transactions are high-value?
- How do sales differ by gender and category?
- How many customers purchase from each category?
- During which time of day are most orders placed?

# 🎓 Skills Demonstrated

- SQL Data Analysis
- Data Cleaning
- Exploratory Data Analysis
- Business Analysis
- Aggregate Functions
- Window Functions
- Date and Time Analysis
- Customer Analysis
- Sales Analysis
- GitHub Project Documentation

---

# 📌 Conclusion

This project demonstrates how SQL can be used to transform raw retail transaction data into meaningful business insights.
Through data exploration and SQL analysis, the project answers questions related to customer behavior, category performance, high-value transactions, monthly sales trends, and customer purchasing patterns.
