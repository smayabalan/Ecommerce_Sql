--  Trigger to update order totals when order_details change

DELIMITER //
CREATE TRIGGER update_order_total 
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE orders 
    SET subtotal = (
        SELECT SUM(line_total) 
        FROM order_details 
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
    
    UPDATE orders 
    SET total_amount = subtotal + tax_amount + shipping_cost - discount_amount WHERE order_id = NEW.order_id;
END //
DELIMITER ;
