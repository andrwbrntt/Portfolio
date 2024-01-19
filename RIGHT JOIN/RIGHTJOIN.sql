/*
Write a query that joins the two tables together
displaying the customer's first name, last name
and order total.

Orders that were paid for in cash don't have any
customer information, but we still want to see
all of the orders.

Order the result by order total from highest to
lowest.
*/

SELECT n.first_name, n.last_name, o.order_total
FROM customer_names n
	RIGHT JOIN customer_orders o ON n.customer_id = o.customer_id
ORDER BY o.order_total DESC;

/*
Expected Output

first_name      last_name        order_total
		                              240
Emily	          Jarvis	          150
Adam	          Johnson	          135
		                              120
Rob	            Gonzalez	        120
Rachel	        Sweeney	          90
Joseph	        James	            50
Jan	            Smith	            30
Theresa	        Scott	            30
Sarah	          Irving	          25
*/
