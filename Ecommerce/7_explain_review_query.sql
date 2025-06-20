--  Example 1: Analyze customer order query performance
EXPLAIN SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_sales
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.status = 'active'
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
GROUP BY c.customer_id, c.first_name, c.last_name;



--  Example 2: Analyze product sales performance query
EXPLAIN SELECT 
    p.product_name,
    p.category,
    SUM(od.quantity) AS total_sold,
    SUM(od.line_total) AS total_revenue
FROM products p
INNER JOIN order_details od ON p.product_id = od.product_id
INNER JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'delivered'
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;
