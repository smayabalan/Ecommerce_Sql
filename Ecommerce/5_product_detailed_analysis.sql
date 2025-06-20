
--  Product performance analysis
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    COUNT(od.order_detail_id) AS times_ordered,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.line_total) AS total_revenue, AVG(od.unit_price) AS average_selling_price,
    p.stock_quantity AS current_stock
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price, p.stock_quantity
ORDER BY total_revenue DESC;



