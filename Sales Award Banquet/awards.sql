/* 
Let's figure out which salespeople won which awards

1. Rookie of the Year
 - 6 month cutoff
	- 2022-06-01 to 2023-05-31

2. The Precision Award
- Highest sales accuracy

3. The Sixer Award
- Sales tickets above the average of sales above $100,000
- Can have multilple winners

4. The High Roller Award
- The most revenue earned

5. The MVP
- The most revenue sold with the highest sale accuracy and highest customer satisfaction
*/


-- 1. Rookie of the Year --

WITH rookie_of_the_year  AS (
  SELECT s.salesperson_id, s.start_date,
  	CONCAT(s.first_name, ' ', s.last_name) AS salesperson_name,
  	SUM(p.sold_price) AS revenue_earned,
  	LEAST(12, TIMESTAMPDIFF(MONTH, s.start_date, '2023-12-31')) AS tenure_in_months 
	-- Provides tenure in months, placing a limit of 1 year from the start date to help with proration calculation --
  FROM salespersons s
  JOIN sold_projects p ON s.salesperson_id = p.salesperson_id
  WHERE s.start_date BETWEEN '2022-06-01' AND '2023-05-31' 
	-- This will limit the salespeople to those hired within the cutoff parameters --
	AND s.termination_date IS NULL 
	-- This will limit the result to salespeople still with the company --
       	AND p.sold_date BETWEEN s.start_date AND DATE_ADD(s.start_date, INTERVAL 1 YEAR) 
	-- This will limit the revenue sum of each eligible salesperson to the parameter of their first year --
  GROUP BY s.salesperson_id
  ORDER BY revenue_earned DESC
)

SELECT *, ROUND(((revenue_earned / tenure_in_months) * 12)) AS proration
FROM rookie_of_the_year
ORDER BY proration DESC;

/*
Expected output

salesperson_id		start_date	salesperson_name	revenue_earned		tenure_in_months	proration
32			2023-02-15	Samuel Young		3967853			10			4761424
31		    	2023-01-06	Ella Walker		4140031			11			4516397
30			2022-11-18	Joseph Robinson		3554279			12			3554279
33			2023-05-01	Scarlett Allen		1965620			7			3369634
29			2022-10-10	Avery Lewis		3083009			12			3083009
27			2022-08-09	Sofia Clark		2820061			12			2820061
26			2022-06-16	Alexander Sanchez	2070347			12			2070347

Rookie of the Year is Samuel Young
*/
