
--  Orders Transaction Table 

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT, customer_id INT NOT NULL,
    order_number VARCHAR(20) UNIQUE NOT NULL, order_date DATETIME DEFAULT CURRENT_TIMESTAMP, required_date DATE, shipped_date DATE, delivery_date DATE,
    order_status ENUM('pending', 'confirmed', 'processing', 'shipped', 'delivered', 
'cancelled', 'returned') DEFAULT 'pending', subtotal DECIMAL(12,2) NOT NULL DEFAULT 0.00, tax_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00, shipping_cost DECIMAL(10,2) NOT NULL DEFAULT 0.00, discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00, total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00, shipping_address TEXT, billing_address TEXT, notes TEXT, created_by VARCHAR(50) ,
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    INDEX idx_customer (customer_id),
    INDEX idx_order_date (order_date),
    INDEX idx_status (order_status),
    INDEX idx_order_number (order_number),
    INDEX idx_total_amount (total_amount) ) ;


--  Order Details Table (for order line items ) 
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT, order_id INT NOT NULL, product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    discount_percent DECIMAL(5,2) DEFAULT 0.00 CHECK (discount_percent >= 0 AND discount_percent <= 100),
    line_total DECIMAL(12,2) NOT NULL DEFAULT 0.00, date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    INDEX idx_order (order_id),
    INDEX idx_product (product_id),
    UNIQUE KEY unique_order_product (order_id, product_id)
) ;

--  Payments Transaction Table 
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT, order_id INT NOT NULL,
    payment_number VARCHAR(20) UNIQUE NOT NULL, payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer', 'cash', 
'check') NOT NULL,
    payment_status ENUM('pending', 'processing', 'completed', 'failed', 'cancelled', 
'refunded') DEFAULT 'pending',
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0), transaction_id VARCHAR(100) , gateway_response TEXT, reference_number VARCHAR(50) , notes TEXT,
    processed_by VARCHAR(50) ,
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    INDEX idx_order (order_id),
    INDEX idx_payment_date (payment_date),
    INDEX idx_status (payment_status),
    INDEX idx_method (payment_method), INDEX idx_amount (amount) ) ;



--  Create indexes

CREATE INDEX idx_orders_date_status ON orders (order_date, order_status);
CREATE INDEX idx_payments_date_status ON payments (payment_date, payment_status);
CREATE INDEX idx_order_details_product_order ON order_details (product_id, order_id);

