drop table  Retail_Sales_Analysis;

create table Retail_Sales_Analysis(transactions_id	int	primary key,
sale_date	date,	
sale_time	time,	
customer_id	int,	
gender	varchar(15),	
age	int,	
category	varchar(15),
quantiy	int,	
price_per_unit	float,	
cogs	float,	
total_sale	float	
);

SELECT * FROM  Retail_Sales_Analysis;

SELECT transactions_id, sale_date, sale_time, customer_id, gender, age, category,
coalesce(quantiy, 0) as quantiy,
coalesce(price_per_unit, 0) as price_per_unit,
coalesce(cogs, 0) as cogs,
coalesce(total_sale, 0) as total_sale
from Retail_Sales_Analysis;

-- Q1 How many sales we have?

select count(*) as total_sales 
from Retail_Sales_Analysis;

--Q2 How many uniuque customers we have ?

select count(distinct customer_id) as number_of_customer
from Retail_Sales_Analysis;

--Q3 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from Retail_Sales_Analysis
where sale_date ='2022-11-05';

--Q4 Write a SQL query to retrieve all transactions where the category is 
-- 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

select *
from Retail_Sales_Analysis
where category ='Clothing' 
and quantiy>3 
and sale_date between'2022-11-01' and '2022-11-30' 
order by sale_date asc;

--Q5 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as sale_per_category,
count(total_sale) as no_of_orders
from Retail_Sales_Analysis
group by category;

-- Q6 Write a SQL query to find the average age of customers 
-- who purchased items from the 'Beauty' category.

select 
round(avg(age), 2) as avg_age
from Retail_Sales_Analysis
where category ='Beauty';

-- Q7 Write a SQL query to find all transactions where the 
-- total_sale is greater than 1000.

select *
from Retail_Sales_Analysis
where total_sale>1000;

-- Q8 Write a SQL query to find the total number of transactions 
-- (transaction_id) made by each gender in each category.

select gender, category, count(transactions_id) as total_no_of_transactions
from Retail_Sales_Analysis
group by gender, category;

-- Q7 Write a SQL query to calculate the average sale for each month. 
-- Find out best selling month in each year

select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from Retail_Sales_Analysis
group by 
extract(year from sale_date), 
extract(month from sale_date) 
order by avg_sale desc limit 2;

-- Q8 Write a SQL query to find the top 5 customers based on the highest 
-- total sales 

select customer_id, sum(total_sale) as total_sale
from Retail_Sales_Analysis
group by customer_id
order by total_sale desc limit 5;

-- Q9 Write a SQL query to find the number of unique customers 
-- who purchased items from each category.

select category, count(distinct customer_id) as unique_cx
from Retail_Sales_Analysis
group by category;

-- Q10 Write a SQL query to create each shift and number of orders 
-- (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select *, 
case
when extract(hour from sale_time) <12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'after noon'
else 'Evening'
END
from Retail_Sales_Analysis;

-- End of project




















