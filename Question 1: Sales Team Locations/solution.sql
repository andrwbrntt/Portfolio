SELECT n.first_name, n.last_name, market
FROM salesperson_name n
LEFT JOIN salesperson_location l ON n.salesperson_id = l.location_id
ORDER BY n.first_name ASC;