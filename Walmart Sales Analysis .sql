SELECT * FROM `walmart project`.Sales;


















-----------------------------------------------------------
------- Feature Engineering--------------------------------

-- time_of_day
SELECT 
	Time,
	(CASE 
	WHEN `Time` BETWEEN  "00.00.00" AND "12.00.00" THEN "Morning"
	WHEN `Time` BETWEEN  "12.01.00" AND "16.00.00" THEN "Afternoon"
	ELSE "Evening"
END
) AS time_of_date
FROM `walmart project`.Sales;

ALTER TABLE Sales ADD COLUMN time_of_day VARCHAR(20);


UPDATE Sales 
SET time_of_day = (CASE 
	WHEN `Time` BETWEEN  "00.00.00" AND "12.00.00" THEN "Morning"
	WHEN `Time` BETWEEN  "12.01.00" AND "16.00.00" THEN "Afternoon"
	ELSE "Evening"
END
);
------ day_name

SELECT date,
DAYNAME(date)
FROM sales;

ALTER TABLE Sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales 
SET day_name = DAYNAME (date);


----month_name--

SELECT 
	date, 
    MONTHNAME(date)
    FROM sales;
    
    ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
    
    UPDATE sales
    SET month_name = MONTHNAME(date);
    
--  -------------------------------

--- how many unique cities does the data have?

SELECT DISTINCT City 
FROM Sales;
--  ------- in which city is each branch?
SELECT DISTINCT Branch, City
FROM Sales;

--  Product----------

--  how many unique product lines does the data have?-----

SELECT 
	COUNT(DISTINCT ProductLine)
FROM Sales;
--    --------- WHAT IS THE MOST COMMON PAYMENT METHOD----
SELECT Payment 
FROM Sales
ORDER BY Payment Desc
LIMIT 1;
--  what is the most selling product lin---
SELECT ProductLine 
FROM Sales
ORDER BY ProductLine DESC
LIMIT 1;

--  what is the total revenue each month---
SELECT month_name AS month,
SUM(Total) AS total_revenue
FROM Sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- what month had the largest cogs?---

SELECT month_name AS month,
SUM(cogs) AS cogs
FROM Sales
GROUP BY month_name
ORDER BY cogs DESC
LIMIT 1;
--  --- WHAT PRODUCT LINE HAD THE LARGEST REVENUE?----

SELECT ProductLine,
SUM(Total) AS Revenue
FROM Sales
GROUP BY ProductLine
ORDER BY Revenue DESC
LIMIT 1;
-- ---- City with the largest revenue?----
SELECT city,
SUM(Total) AS Revenue
FROM Sales
GROUP BY City
ORDER BY Revenue DESC
LIMIT 1;
--  what product line has the largest VAT?---
SELECT ProductLine,
AVG(VAT) AS avg_tax
FROM Sales
GROUP BY ProductLine
ORDER BY avg_tax desc
LIMIT 1;
--   fetch each product line and add a column to those product lines showing good if its greater than avg sales or bad if not----
SELECT AVG( Total)
FROM Sales;

SELECT ProductLine, 
AVG(Total) AS Avg
GROUP BY ProductLine
ORDER BY Avg
FROM Sales;

-- --- which branch sold more products than the average product sold?----
SELECT Branch, 
SUM(quantity) AS qty
FROM Sales
GROUP BY Branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM Sales);
-- what is the most common product line for each gender?-----
SELECT 
	ProductLine,
	Gender,
COUNT(Gender) AS total_count
FROM Sales
GROUP BY Gender, ProductLine
ORDER BY total_count DESC;
-- what is the average rating of each product line?-----
SELECT  
	AVG(rating) AS avg_rating, 
	ProductLine 
FROM Sales
GROUP BY ProductLine
ORDER BY avg_rating DESC;

-- SALES------

-- number of sales made in each time of day per workday-----
SELECT time_of_day,
COUNT(*) AS total_sales
FROM Sales
WHERE day_name = "Saturday"
GROUP BY time_of_day
ORDER BY Time_of_Day DESC;

-- which of the customer types bring the most revenue-----
SELECT Customer_type,
SUM(Total) AS Revenue
FROM Sales
GROUP BY Customer_type
ORDER BY Revenue;
-- which city has the largest tax?-----
SELECT City, 
AVG(VAT)AS VAT
FROM Sales
GROUP BY City
ORDER BY VAT DESC;

-- which customer type pay the most tax?----
SELECT Customer_type, 
AVG(VAT)AS VAT
FROM Sales
GROUP BY Customer_type
ORDER BY VAT DESC;
-- how many unique customer types does the data have?-----
SELECT 
	DISTINCT Customer_type
FROM Sales;

-- how many unique payment methods in the data?----
SELECT 
DISTINCT payment
FROM Sales;

-- which customer type buys the most?-------
SELECT Customer_type,
COUNT(*) AS customer_count
FROM Sales
GROUP BY customer_type;

-- most common gender in shoppers?----
SELECT Gender,
COUNT(*) AS count
FROM Sales
GROUP BY Gender;
--   gender distribution per branch?----
SELECT Gender,
COUNT(*) AS count
FROM Sales
WHERE branch = "C" 
GROUP BY Gender;
-- what time of day do most customers give ratings?---
SELECT time_of_day,
COUNT(Rating) AS ratings
FROM Sales
GROUP BY time_of_day
ORDER BY ratings;

-- what time of day do customers give highest ratings?---
SELECT time_of_day,
AVG(Rating) AS ratings
FROM Sales
GROUP BY time_of_day
ORDER BY ratings;
-- -- what time of day do most customers give highest ratings per branch?---
SELECT time_of_day,
AVG(Rating) AS ratings
FROM Sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY ratings;
-- which day of the week has the best avg rating?-----
SELECT day_name,
AVG(Rating) AS ratings
FROM Sales
GROUP BY day_name
ORDER BY ratings;
-- -- -- what day do most customers give highest ratings per branch?---
SELECT day_name,
AVG(Rating) AS ratings
FROM Sales
WHERE branch = "A"
GROUP BY day_name
ORDER BY ratings;


