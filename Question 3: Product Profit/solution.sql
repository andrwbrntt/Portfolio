SELECT *, ((sold_price - production_cost) * amount_sold) AS profit
FROM product_profit
ORDER BY profit DESC
LIMIT 1;