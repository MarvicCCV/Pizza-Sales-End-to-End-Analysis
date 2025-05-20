-- BASIC EXPLORATION AND KPI QUERIES

SELECT *
FROM pizza_sales


-- KPI
-- KPI 1: Total Revenue
SELECT 
	CAST(SUM(total_price) AS NUMERIC(10,3)) AS total_revenue
FROM
	pizza_sales

-- KPI 2: Average Order Value
SELECT 
	CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS NUMERIC(10,3)) AS average_order_value
FROM 
	pizza_sales


-- KPI 3: Total Pizza sold
SELECT 
	SUM(quantity) AS total_pizza_sold
FROM
	pizza_sales


-- KPI 4: Total Orders
SELECT 
	COUNT(DISTINCT order_id) AS num_of_orders
FROM
	pizza_sales


-- KPI 5: Average Pizza Per Order
SELECT 
	ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS avg_pizza_per_order
FROM 
	pizza_sales