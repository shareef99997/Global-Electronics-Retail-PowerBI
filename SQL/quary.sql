-- Prepere Data For Visulaization Using Power BI


-- Check for NULL values in all tables
SELECT 'customers' AS table_name, COUNT(*) AS null_values FROM customers WHERE customer_key IS NULL
UNION ALL
SELECT 'products', COUNT(*) FROM products WHERE product_key IS NULL
UNION ALL
SELECT 'sales', COUNT(*) FROM sales WHERE order_number IS NULL
UNION ALL
SELECT 'stores', COUNT(*) FROM stores WHERE store_key IS NULL
UNION ALL
SELECT 'exchange_rate', COUNT(*) FROM stores WHERE store_key IS NULL;

----------------------------------------------------------------------------------------------------------

-- Trim customers columns string values to remove spacing 
UPDATE customers
SET name = INITCAP(TRIM(name)),
    city = INITCAP(TRIM(city)),
    state = INITCAP(TRIM(state)),
    country = INITCAP(TRIM(country));
	
-- Trim products columns string values to remove spacing 
UPDATE products
SET 
    product_name = INITCAP(TRIM(product_name)),
    brand = INITCAP(TRIM(brand)),
    color = INITCAP(TRIM(color)),
    subcategory = INITCAP(TRIM(subcategory)),
    category = INITCAP(TRIM(category));

-- Trim stores columns string values to remove spacing 
UPDATE stores
SET 
    country = INITCAP(TRIM(country)),
    state = INITCAP(TRIM(state));

-- Trim sales columns string values to remove spacing 
UPDATE sales
SET 
    currency_code = UPPER(TRIM(currency_code));

-- Trim exchange_rates columns string values to remove spacing 
UPDATE exchange_rates
SET 
    currency = UPPER(TRIM(currency));


------------------------------------------------------------------------------------------------------------

-- Create a new column for sales in USD
ALTER TABLE sales DROP COLUMN IF EXISTS total_sales_usd;

ALTER TABLE sales ADD COLUMN total_sales_usd NUMERIC;


-- Convert sales to USD using exchange rates
UPDATE sales s
SET total_sales_usd = subquery.total_sales_usd
FROM (
	SELECT 
        s.order_number, 
        s.line_item,
        ROUND((s.quantity * p.unit_price_usd) / e.exchange_rate, 2) AS total_sales_usd
    FROM sales s
    JOIN products p ON s.product_key = p.product_key
    JOIN exchange_rates e 
	ON s.currency_code = e.currency
    AND s.order_date = e.date
) AS subquery
WHERE s.order_number = subquery.order_number
AND s.line_item = subquery.line_item;





