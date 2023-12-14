SELECT customer_id, ROUND((purchased_items / cart_items) * 100, 2) AS percentage
FROM customer_carts
ORDER BY customer_id DESC;