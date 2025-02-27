SELECT TOP (1000) [transactions_id]
      ,[sale_date]
      ,[sale_time]
      ,[customer_id]
      ,[gender]
      ,[age]
      ,[category]
      ,[quantiy]
      ,[price_per_unit]
      ,[cogs]
      ,[total_sale]
 FROM [sqL_PROJECT_p1].[dbo].[retail_sales ]

  select
        count(*) from retail_sales 
  
  --DATA CLEANING--
  SELECT * FROM RETAIL_SALES
  WHERE
       TRANSACTIONS_ID IS NULL
	   OR
	   SALE_DATE IS NULL
	   OR
	   SALE_TIME IS NULL
	   OR
	   gender IS NULL
	   OR
	   CATEGORY IS NULL
	   OR
	   QUANTIY IS NULL
	   OR
	   COGS IS NULL
	   OR
	   TOTAL_SAle is NULL;

	   --
	   DELETE FROM RETAIL_SALES
	   WHERE
	        TRANSACTIONS_ID IS NULL
	   OR
	   SALE_DATE IS NULL
	   OR
	   SALE_TIME IS NULL
	   OR
	   gender IS NULL
	   OR
	   CATEGORY IS NULL
	   OR
	   QUANTIY IS NULL
	   OR
	   COGS IS NULL
	   OR
	   TOTAL_SAle is NULL;

--DATA EXPLORATION--

--How mant sales we have?
SELECT COUNT(*) AS TOTAL_SALE FROM RETAIL_SALES

--How many unique customers we have?
SELECT COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS FROM RETAIL_SALES

--How many categories we have?
SELECT DISTINCT category FROM RETAIL_SALES

--Data Analysis & Business key problems and Answers--

--Q1. Write a SQL query to retrieve all columns for sale made on '2022-11-05'--

SELECT * 
FROM RETAIL_SALES
WHERE SALE_DATE = '2022-11-05';

--Q2. Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of 'Nov-2022'--

SELECT *
FROM RETAIL_SALES
WHERE CATEGORY = 'CLOTHING'
  AND SALE_DATE >= '2022-11-01'
  AND SALE_DATE < '2022-12-01'   
  AND QUANTIY >= 4;

--Q3. Write a SQL query to calculate the total sales(total_sale) for each category--SELECT 

SELECT 
      CATEGORY,
	  SUM(TOTAL_SALE) AS NET_SALE,
	  COUNT(*) AS TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY CATEGORY

--Q4.Write a SQL query to find the average age of customers who purchased items from the 'beauty' category.--

select 
     avg(AGE) AS AVG_AGE
	 FROM RETAIL_SALES
	 WHERE CATEGORY = 'BEAUTY'

--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000--

select * from retail_sales
where total_sale > 1000

--Q6. Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category--

select 
    category,
    gender,
    count(*) as total_trans
from retail_sales
group by category,gender
order by category

--Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.--

SELECT
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t
WHERE rank = 1;

--Q8. Write a SQL query to find the top 5 customers based on higest total sales.--

SELECT TOP 5 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC;

--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.--

select
      category,
	  count(distinct customer_id) as unique_ci
	  from retail_sales
	  group by category

--Q10. Write a SQl query to calculate each shift and number of orders (Example morning <=12, afternoon between 12 & 17, evening > 17).--

WITH hourly_sale AS (
    SELECT *,    
           CASE 
               WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
               WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders 
FROM hourly_sale
GROUP BY shift;


---End of Project---

	        

