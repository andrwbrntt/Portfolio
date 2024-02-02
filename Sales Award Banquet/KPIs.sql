/*
Let's find the KPIs needed

1. Total Revenue
2. Total Number of Sales
3. Average Ticket
4. Average Sale Accuracy
5. Average Customer Satisfaction
*/


-- Single Queries

-- 1. Total Revenue

SELECT SUM(sold_price) AS revenue_2023
FROM sold_projects
WHERE YEAR(sold_date) = 2023;

-- Expected output for 2023 revenue = 122298912


SELECT SUM(sold_price) AS revenue_2022
FROM sold_projects
WHERE YEAR(sold_date) = 2022;

-- Expected output for 2022 revenue = 70487142




-- 2. Total Number of Sales

SELECT COUNT(project_id) AS num_of_sales_2023
FROM sold_projects
WHERE YEAR(sold_date) = 2023;

-- Expected output for 2023 number of sales = 1330


SELECT COUNT(project_id) AS num_of_sales_2022
FROM sold_projects
WHERE YEAR(sold_date) = 2022;

-- Expected output for 2022 number of sales = 1193




-- 3. Average Ticket

SELECT ROUND(AVG(sold_price)) AS avg_sale_2023
FROM sold_projects
WHERE YEAR(sold_date) = 2023;

-- Expected output for 2023 average ticket rounded to the nearest dollar = 91954


SELECT ROUND(AVG(sold_price)) AS avg_sale_2022
FROM sold_projects
WHERE YEAR(sold_date) = 2022;

-- Expected output for 2022 average sale rounded to the nearest dollar = 59084




-- 4. Average Customer Satisfaction

SELECT ROUND(AVG(sale_accuracy),1) AS avg_accuracy_2023
FROM sold_projects
WHERE YEAR(sold_date) = 2023;

-- Expected output for 2023 average sale accuracy rounded to 1 decimal place = 8.0


SELECT ROUND(AVG(sale_accuracy),1) AS avg_accuracy_2022
FROM sold_projects
WHERE YEAR(sold_date) = 2022;

-- Expected output for 2022 average sale accuracy rounded to 1 decimal place = 7.7




-- 5. Average Customer Satisfaction

SELECT ROUND(AVG(customer_satisfaction),1) AS avg_satisfaction_2023
FROM sold_projects
WHERE YEAR(sold_date) = 2023;

-- Expected output for 2023 average customer satisfaction rounded to 1 decimal place = 7.4


SELECT ROUND(AVG(sale_accuracy),1) AS avg_accuracy_2022
FROM sold_projects
WHERE YEAR(sold_date) = 2022;

-- Expected output for 2022 average customer satisfaction rounded to 1 decimal place = 7.7




-- Subqueries

-- 1. Total Sales

SELECT
	(SELECT SUM(sold_price)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) AS revenue_2023,
	(SELECT SUM(sold_price)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022) AS revenue_2022,
	((SELECT SUM(sold_price)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) -
	(SELECT SUM(sold_price)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022)) AS revenue_difference;
    
/*
Expected output

revenue_2023			revenue_2022			revenue_difference
122298912			70487142			51811770
*/




-- 2. Total Number of Sales

SELECT
	(SELECT COUNT(project_id)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) AS total_sales_2023,
	(SELECT COUNT(project_id)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022) AS total_sales_2022,
	((SELECT COUNT(project_id)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) -
	(SELECT COUNT(project_id)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022)) AS total_sales_diff;
    
/*
Expected output
    
total_sales_2023			total_sales_2022			total_sales_diff
1330					1193					137
*/



    
-- 3. Average Ticket
    
SELECT
	(SELECT ROUND(AVG(sold_price))
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) AS avg_ticket_2023,
	(SELECT ROUND(AVG(sold_price))
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022) AS avg_ticket_2022,
	((SELECT ROUND(AVG(sold_price))
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) -
	(SELECT ROUND(AVG(sold_price))
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022)) AS avg_ticket_diff;
    
/*
Expected output
    
avg_ticket_2023			avg_ticket_2022			avg_ticket_diff
91954				59084				32870
*/



    
-- 4. Average Sale Accuracy
    
SELECT
	(SELECT ROUND(AVG(sale_accuracy), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) AS sale_accuracy_2023,
	(SELECT ROUND(AVG(sale_accuracy), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022) AS sale_accuracy_2022,
	((SELECT ROUND(AVG(sale_accuracy), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) -
	(SELECT ROUND(AVG(sale_accuracy), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022)) AS accuracy_diff;
    
/*
Expected output
    
sale_accuracy_2023			sale_accuracy_2022			accuracy_diff
8.0					7.7					0.3
*/
    



-- 5. Average Customer Satisfaction

SELECT
	(SELECT ROUND(AVG(customer_satisfaction), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) AS satisfaction_2023,
	(SELECT ROUND(AVG(customer_satisfaction), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022) AS satisfaction_2022,
	((SELECT ROUND(AVG(customer_satisfaction), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2023) -
	(SELECT ROUND(AVG(customer_satisfaction), 1)
	FROM sold_projects
	WHERE YEAR(sold_date) = 2022)) AS satisfaction_diff;
    
/*
Expected output
    
satisfactions_2023			satisfaction_2022			satisfaction_diff
7.4					7.8					-0.4
*/
    
    
    
/*
We'll be using Power BI for our visualization tool,
so let's make a table that will give us the smoothest
transition
*/

WITH sales_2023 AS (
	SELECT
	MONTH(sold_date) AS month_number,
        MONTHNAME(sold_date) AS month_name,
        SUM(sold_price) AS revenue_2023,
        COUNT(project_id) AS total_sales_2023,
        ROUND(AVG(sold_price)) AS avg_ticket_2023,
        ROUND(AVG(sale_accuracy), 1) AS sale_accuracy_2023,
        ROUND(AVG(customer_satisfaction), 1) AS customer_satisfaction_2023
	FROM sold_projects
    WHERE YEAR(sold_date) = 2023
    GROUP BY 
	MONTH(sold_date),
        MONTHNAME(sold_date)
),
sales_2022 AS (
	SELECT
	MONTH(sold_date) AS month_number,
	-- This will extract the month as number
        MONTHNAME(sold_date) AS month_name,
	-- This will extract the month's name
        SUM(sold_price) AS revenue_2022,
        COUNT(project_id) AS total_sales_2022,
        ROUND(AVG(sold_price)) AS avg_ticket_2022,
        ROUND(AVG(sale_accuracy), 1) AS sale_accuracy_2022,
        ROUND(AVG(customer_satisfaction), 1) AS customer_satisfaction_2022
	FROM sold_projects
    WHERE YEAR(sold_date) = 2022
    GROUP BY 
	MONTH(sold_date),
        MONTHNAME(sold_date)
)

SELECT s23.month_number, s23.month_name, s23.revenue_2023, s23.total_sales_2023,
s23.avg_ticket_2023, s23.sale_accuracy_2023, s23.customer_satisfaction_2023,
s22.revenue_2022, s22.total_sales_2022, s22.avg_ticket_2022, s22.sale_accuracy_2022,
s22.customer_satisfaction_2022
FROM sales_2023 s23
JOIN sales_2022 s22 ON s23.month_number = s22.month_number;

/*
Expected output

month_number	month_name	revenue_2023	total_sales_2023	avg_ticket_2023		sale_accuracy_2023	customer_satisfaction_2023	revenue_2022		total_sales_2022	avg_ticket_2022		sale_accuracy_2022	customer_satisfaction_2022
1		January		10410819	109			95512			8.1			7.3				6986414			115	      		60751			7.7	      		8.2
2		February	9313658		99			94077			8.3		      	7.5				8077136	  		134			60277    		7.5			8.0
3		March		9421557		108			87237	    		8.0			7.2				7654299		  	121			63259		    	7.5			8.1
4		April		9501713		102			93154			8.0			7.3	        		6911723			112	      		61712			7.4      		8.2
5		May		12186878	132			92325			8.0      		7.2				6948030			114			60948		    	7.4			8.3
6		June		11755002	119	      		98782		    	7.9			7.4				5701315			98			58177			7.8			7.7
7		July		10302070	117			88052			8.1			7.4        			4882924		  	80			61037		    	7.9	      		7.4
8		August		11432946	124		      	92201		    	8.0		      	7.7				4538748			84			54033			7.9			7.6
9		September	11559232	124			93220			7.9			7.4				4794650			81			59193	    		8.1		      	7.7
10		October		9183563		108	      		85033			7.9			7.6		        	5441432			103			52829			7.9			7.3
11		November	9481343		102			92954			7.9			7.5				4858863  		92			52814			7.8			7.4
12		December	7750131		86			90118			7.9			7.3				3691608	  		59			62570			7.8			7.5
*/
