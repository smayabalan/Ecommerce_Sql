
--  Create database
CREATE DATABASE ecommerce_sales;
USE ecommerce_sales;


--  Customers Master Table 
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT, first_name VARCHAR(50) NOT NULL, last_name VARCHAR(50) NOT NULL, email VARCHAR(100) UNIQUE NOT NULL, phone VARCHAR(20) , address TEXT, city VARCHAR(50) , state VARCHAR(50) , zip_code VARCHAR(10) , country VARCHAR(50) DEFAULT 'USA',
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,  
    date_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    INDEX idx_email (email),
    INDEX idx_name (last_name, first_name),
    INDEX idx_location (city, state) ) ;


--  Products Master Table 
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT, product_name VARCHAR(100) NOT NULL, product_code VARCHAR(50) UNIQUE NOT NULL, description TEXT, category VARCHAR(50) NOT NULL, brand VARCHAR(50) ,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0), cost DECIMAL(10,2) NOT NULL CHECK (cost >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0), min_stock_level INT DEFAULT 10, weight DECIMAL(8 ,2), dimensions VARCHAR(50) ,
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, status ENUM('active', 'inactive', 'discontinued') DEFAULT 'active',
    INDEX idx_product_code (product_code),
    INDEX idx_category (category),
    INDEX idx_price (price),
    INDEX idx_stock (stock_quantity) ) ;


--  Create indexes
CREATE INDEX idx_customers_email_status ON customers (email, status);
CREATE INDEX idx_products_category_status ON products (category, status);


