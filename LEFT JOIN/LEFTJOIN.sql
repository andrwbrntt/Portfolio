/*
Write a query that joins the two tables together
displaying the customer's first name, last name
and order total.

Include customers whose order total is null.

Order the output so that the customers whose
order is null display first
*/

SELECT n.first_name, n.last_name, o.order_total
FROM customer_names n
	LEFT JOIN customer_orders o ON n.customer_id = o.customer_id
ORDER BY o.order_total;

/*
Expected Output

first_name      last_name        order_total
Sarah	        Irving	
Theresa	        Scott	
Grant	        Barnett	          120
Rob	        Gonzalez	  120
Adam	        Johnson	          135
Emily	        Jarvis	          150
Brian	        Greyson	          240
Jan	        Smith	          30
Joseph	        James	          50
Rachel	        Sweeney	          90
*/
