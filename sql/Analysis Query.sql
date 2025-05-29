-- ANALYSIS QUERIES
-- QUery to alter the data types of order_date and order_time

ALTER TABLE pizza_sales
ALTER COLUMN order_date TYPE DATE
USING TO_DATE(order_date, 'DD-MM-YYYY')

ALTER TABLE pizza_sales
ALTER COLUMN order_time TYPE TIME
USING order_time::TIME

-- 1. Count the number of order per day, week, then month

SELECT *
FROM pizza_sales
-- PER DAY
SELECT 
	TO_CHAR(order_date, 'Day') AS day,
	COUNT(*) AS num_of_orders,
	ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),3) AS percentage_order
FROM
	pizza_sales
GROUP BY
		day
ORDER BY
	num_of_orders DESC

-- PER WEEK 

SELECT 
	DATE_PART('month', order_date) AS month_number,
	TO_CHAR(order_date, 'month') AS month_name,
	COUNT(*) AS num_of_orders

FROM 
	pizza_sales
GROUP BY 
	month_number, month_name
ORDER BY num_of_orders DESC

-- 2. Percentage of pizza sold per pizza category

-- For the number of orders

SELECT *
FROM pizza_sales

SELECT 
	pizza_category,
	COUNT(*) AS num_of_orders_per_category,
	ROUND(COUNT(*)*100.0 / SUM(COUNT(*)) OVER(),3) || ' %' AS category_percentage
FROM 
	pizza_sales
GROUP BY
	pizza_category
ORDER BY
	num_of_orders_per_category DESC

-- For the total sales

SELECT 
	pizza_category,
	ROUND(SUM(total_price)::numeric,2) AS total_sales_per_category,
	ROUND((SUM(totaL_price) * 100.0 / SUM(SUM(total_price)) OVER())::numeric, 2) AS percentage_per_category
FROM pizza_sales
GROUP BY
	pizza_category

-- With dynamic filtering

SELECT 
	pizza_category,
	SUM(total_price)::numeric AS total_sales_per_category,
	SUM(totaL_price) * 100.0 / SUM(SUM(total_price)) OVER() AS percentage_per_category
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 12
GROUP BY
	pizza_category

-- Top 5 and worst 5 pizza best sellers

--TOP 5
SELECT 
	pizza_name,
	ROUND(SUM(total_price)::numeric,2) AS total_sales,
	COUNT(*) AS num_of_pizza_sold,
	SUM(quantity) AS total_quantity_sold
FROM  
	pizza_sales
GROUP BY
	pizza_name
ORDER BY 
	total_sales DESC,
	num_of_pizza_sold DESC
LIMIT 5

-- WORST 5
SELECT 
	pizza_name,
	ROUND(SUM(total_price)::numeric,2) AS total_sales,
	COUNT(*) AS num_of_pizza_sold,
	SUM(quantity) AS total_quantity_sold
FROM 
	pizza_sales
GROUP BY
	pizza_name
ORDER BY 
	total_sales,
	num_of_pizza_sold DESC
LIMIT 5