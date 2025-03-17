-- Drop Tables if Exists
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
DROP TABLE IF EXISTS exchange_rates CASCADE;

-- 1. Customers Table
CREATE TABLE customers (
    customer_key INT PRIMARY KEY,
    gender VARCHAR(10),
    name VARCHAR(100),
    city VARCHAR(100),
    state_code VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(10),
    country VARCHAR(100),
    continent VARCHAR(100),
    birthday DATE
);

-- 2. Exchange Rates Table
CREATE TABLE exchange_rates (
    date DATE,
    currency VARCHAR(10),
    exchange_rate NUMERIC
);

-- 3. Products Table
CREATE TABLE products (
    product_key INT PRIMARY KEY,
    product_name VARCHAR(255),
    brand VARCHAR(100),
    color VARCHAR(50),
    unit_cost_usd NUMERIC,
    unit_price_usd NUMERIC,
    subcategory_key INT,
    subcategory VARCHAR(100),
    category_key INT,
    category VARCHAR(100)
);

-- 4. Stores Table
CREATE TABLE stores (
    store_key INT PRIMARY KEY,
    country VARCHAR(100),
    state VARCHAR(100),
    square_meters INT,
    open_date DATE
);


-- 5. Sales Table
CREATE TABLE sales (
    order_number INT,
    line_item INT,
    order_date DATE,
    delivery_date DATE NULL,
    customer_key INT,
    store_key INT,
    product_key INT,
    quantity INT,
    currency_code VARCHAR(10),
    PRIMARY KEY (order_number, line_item),
    FOREIGN KEY (customer_key) REFERENCES customers(customer_key),
    FOREIGN KEY (product_key) REFERENCES products(product_key),
    FOREIGN KEY (store_key) REFERENCES stores(store_key)
);

