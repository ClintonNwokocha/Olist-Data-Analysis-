-- creating tables
CREATE TABLE customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix INTEGER,
    customer_city TEXT,
    customer_state TEXT
);

CREATE TABLE geo_location (
    geolocation_zip_code_prefix INTEGER NOT NULL,
    geolocation_lat FLOAT NOT NULL,
    geolocation_lng FLOAT NOT NULL,
    geolocation_city TEXT NOT NULL,
    geolocation_state TEXT NOT NULL
);


CREATE TABLE items (
    order_id TEXT NOT NULL,
    order_item_id INTEGER NOT NULL,
    product_id TEXT NOT NULL,
    seller_id TEXT NOT NULL,
    shipping_limit_date TEXT NOT NULL,
    price FLOAT NOT NULL,
    freight_value FLOAT NOT NULL
);

CREATE TABLE payments (
    order_id TEXT NOT NULL,
    payment_sequential INTEGER NOT NULL,
    payment_type TEXT NOT NULL,
    payment_installments INTEGER NOT NULL,
    payment_value FLOAT NOT NULL
);



CREATE TABLE reviews (
    review_id TEXT NOT NULL,
    order_id TEXT NOT NULL,
    review_score INTEGER NOT NULL,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP WITHOUT TIME ZONE,
    review_answer_timestamp TIMESTAMP WITHOUT TIME ZONE
);



CREATE TABLE orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE products (
    product_id TEXT,
    product_category_name TEXT,
    product_name_length FLOAT,
    product_description_length FLOAT,
    product_photos_qty FLOAT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

CREATE TABLE sellers (
    seller_id TEXT NOT NULL,
    seller_zip_code_prefix INTEGER NOT NULL,
    seller_city TEXT NOT NULL,
    seller_state TEXT NOT NULL
);



CREATE TABLE translation (
    product_category_name TEXT,
    product_category_name_english TEXT
);
------------------------------------------------------------------


-- Check information schemas of columns of each table
SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'customers';

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'geo_location';

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'items';

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'payments';

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'reviews';

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'products';

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'sellers';

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'translation';
------------------------------------------------------------------

-- Select random rows from each table
SELECT *
FROM customers
ORDER BY RANDOM()
LIMIT 5;
-- customer_city values are in lower case, they should be formatted in title cases
-- customer state values are in two letter codes, the corresponding state names gives a more appropraite description

SELECT *
FROM geo_location
ORDER BY RANDOM()
LIMIT 5;
-- customer_city values are in lower case, they should be formatted in title cases
-- customer state values are in two letter codes, the corresponding state names gives a more appropraite description
-- some city names contain diacritic names, like "florianópolis"

SELECT *
FROM items
ORDER BY RANDOM()
LIMIT 5

SELECT *
FROM payments
ORDER BY RANDOM()
LIMIT 5;

SELECT *
FROM reviews
ORDER BY RANDOM()
LIMIT 5;

SELECT *
FROM products
ORDER BY RANDOM()
LIMIT 5;

SELECT *
FROM olist_sellers
ORDER BY RANDOM()
LIMIT 5;
-- customer_city values are in lower case, they should be formatted in title cases
-- customer state values are in two letter codes, the corresponding state names gives a more appropraite description

SELECT *
FROM translation
ORDER BY RANDOM()
LIMIT 5;
------------------------------------------------------------------

-- Check for missing values in each table

-- customers table
SELECT
	COUNT(*) - COUNT(customer_id) AS missing_customer_id,
	COUNT(*) - COUNT(customer_unique_id) AS missing_unique_id,
	COUNT(*) - COUNT(customer_zip_code_prefix) AS missing_zip_code,
	COUNT(*) - COUNT(customer_city) AS missing_city,
	COUNT(*) - COUNT(customer_state) AS missing_state
FROM customers;
-- no null values

-- geo_location table
SELECT
    COUNT(*) - COUNT(geolocation_zip_code_prefix) AS missing_zip_code,
    COUNT(*) - COUNT(geolocation_lat) AS missing_latitude,
    COUNT(*) - COUNT(geolocation_lng) AS missing_longitude,
    COUNT(*) - COUNT(geolocation_city) AS missing_city,
    COUNT(*) - COUNT(geolocation_state) AS missing_state
FROM geo_location;
-- no null values

-- items table
SELECT
    COUNT(*) - COUNT(order_id) AS missing_id,
    COUNT(*) - COUNT(order_item_id) AS missing_item_id,
    COUNT(*) - COUNT(product_id) AS missing_product_id,
    COUNT(*) - COUNT(seller_id) AS missing_seller_id,
    COUNT(*) - COUNT(shipping_limit_date) AS missing_shipping_limit_date,
    COUNT(*) - COUNT(price) AS missing_price,
    COUNT(*) - COUNT(freight_value) AS missing_freight_value
FROM items;
--no null values

-- items table
SELECT
    COUNT(*) - COUNT(order_id) AS missing_id,
    COUNT(*) - COUNT(customer_id) AS missing_customer_id,
    COUNT(*) - COUNT(order_status) AS missing_status,
    COUNT(*) - COUNT(order_purchase_timestamp) AS missing_purchase_timestamp,
    COUNT(*) - COUNT(order_approved_at) AS missing_approved_time,
	COUNT(*) - COUNT(order_delivered_carrier_date) AS missing_delivered_carrier_date,
	COUNT(*) - COUNT(order_delivered_customer_date) AS missing_delivered_customer_date,
	COUNT(*) - COUNT(order_estimated_delivery_date) AS missing_estimated_delivery_date
FROM orders;
-- Contains null values

-- payments table
SELECT
    COUNT(*) - COUNT(order_id) AS missing_id,
    COUNT(*) - COUNT(payment_sequential) AS missing_payment_sequential,
    COUNT(*) - COUNT(payment_type) AS missing_payment_type,
    COUNT(*) - COUNT(payment_installments) AS missing_payment_installments,
    COUNT(*) - COUNT(payment_value) AS missing_payment_value
FROM payments;

--no null values

-- reviews table
SELECT
    COUNT(*) - COUNT(review_id) AS missing_id,
    COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(review_score) AS missing_review_score,
    COUNT(*) - COUNT(review_comment_title) AS missing_comment_title,
    COUNT(*) - COUNT(review_comment_message) AS missing_comment,
    COUNT(*) - COUNT(review_creation_date) AS missing_date,
    COUNT(*) - COUNT(review_answer_timestamp) AS missing_answer_timestamp
FROM reviews;

-- no null values

-- products table
SELECT
    COUNT(*) - COUNT(product_id) AS missing_id,
    COUNT(*) - COUNT(product_category_name) AS missing_category_name,
    COUNT(*) - COUNT(product_name_length) AS missing_name_length,
    COUNT(*) - COUNT(product_description_length) AS missing_desc_length,
    COUNT(*) - COUNT(product_photos_qty) AS missing_photos_qty,
    COUNT(*) - COUNT(product_weight_g) AS missing_weight,
    COUNT(*) - COUNT(product_length_cm) AS missing_length,
    COUNT(*) - COUNT(product_height_cm) AS missing_height,
    COUNT(*) - COUNT(product_width_cm) AS missing_width
FROM products;
-- no null values

-- olist_sellers table
SELECT
    COUNT(*) - COUNT(seller_id) AS missing_seller_id,
    COUNT(*) - COUNT(seller_zip_code_prefix) AS missing_zip_code,
    COUNT(*) - COUNT(seller_city) AS missing_city,
    COUNT(*) - COUNT(seller_state) AS missing_state
FROM sellers;
-- no null values

-- product_name_translation table
SELECT
    COUNT(*) - COUNT(product_category_name) AS missing_name,
    COUNT(*) - COUNT(product_category_name_english) AS missing_translation
FROM translation;
-- no null values

------------------------------------------------------------------
-- cleaning tables with tidiness and quality issues

-- customers table
-- Capitalize the first letter of each word in 'customer_city' field
UPDATE customers
SET customer_city = INITCAP(customer_city);

-- Replace state abbreviations with their full names in 'customer_state' field
UPDATE customers
SET customer_state = 
CASE 
    WHEN customer_state = 'RS' THEN 'Rio Grande do Sul'
    WHEN customer_state = 'SC' THEN 'Santa Catarina'
    WHEN customer_state = 'MG' THEN 'Minas Gerais'
    WHEN customer_state = 'DF' THEN 'Distrito Federal'
    WHEN customer_state = 'RN' THEN 'Rio Grande do Norte'
    WHEN customer_state = 'SP' THEN 'Sao Paulo'
    WHEN customer_state = 'GO' THEN 'Goias'
    WHEN customer_state = 'AM' THEN 'Amazonas'
    WHEN customer_state = 'PA' THEN 'Para'
    WHEN customer_state = 'PB' THEN 'Paraiba'
    WHEN customer_state = 'PE' THEN 'Pernambuco'
    WHEN customer_state = 'AP' THEN 'Amapa'
    WHEN customer_state = 'ES' THEN 'Espirito Santo'
    WHEN customer_state = 'TO' THEN 'Tocantins'
    WHEN customer_state = 'MT' THEN 'Mato Grosso'
    WHEN customer_state = 'RR' THEN 'Roraima'
    WHEN customer_state = 'PI' THEN 'Piaui'
    WHEN customer_state = 'PR' THEN 'Parana'
    WHEN customer_state = 'BA' THEN 'Bahia'
    WHEN customer_state = 'CE' THEN 'Ceara'
    WHEN customer_state = 'AC' THEN 'Acre'
    WHEN customer_state = 'RJ' THEN 'Rio de Janeiro'
    WHEN customer_state = 'MA' THEN 'Maranhao'
    WHEN customer_state = 'AL' THEN 'Alagoas'
    WHEN customer_state = 'RO' THEN 'Rondonia'
    WHEN customer_state = 'SE' THEN 'Sergipe'
    WHEN customer_state = 'MS' THEN 'Mato Grosso do Sul'
    ELSE customer_state
END;

-- customer_city values are in lower case, they should be formatted in title cases
-- customer state values are in two letter codes, the corresponding state names gives a more appropraite description
-- some city names contain diacritic names, like "florianópolis"

-- geo_location table
-- creating unaccent extension to handle removing diacritic characters from geolocation_city column
CREATE EXTENSION unaccent;

-- Updating the geolocation_city column in the geo_location table
-- This is done to remove any diacritic signs from the city names
-- For example, it will change "florianópolis" to "florianopolis"
UPDATE geo_location
SET geolocation_city = unaccent(geolocation_city);

-- Updating the geolocation_city column in geo_location table
-- The lower case values are changed to upper case values
-- for example "serra" to "Serra"
UPDATE geo_location
SET geolocation_city = INITCAP(geolocation_city);

UPDATE geo_location
SET geolocation_city = REPLACE(geolocation_city, '`', '');

-- Normalize '´Teresopolis'
UPDATE geo_location
SET geolocation_city = 'Teresopolis'
WHERE geolocation_city = '´Teresopolis';

-- Normalize '4º Centenario' and '4o. Centenario'
UPDATE geo_location
SET geolocation_city = '4th Centenario'
WHERE geolocation_city IN ('4º Centenario', '4o. Centenario');

-- Normalize '* Cidade' 
UPDATE geo_location
SET geolocation_city = 'Cidade'
WHERE geolocation_city = '* Cidade' 

-- Normalize variations of 'Santa Barbara Do Este' to a standard form
UPDATE geo_location
SET geolocation_city = 'Santa Barbara Do Este'
WHERE geolocation_city IN ('Santa Barbara DOeste', 'Santa Barbara Doeste', 'Santa Barbara D Oeste');

-- Remove leading dots from city name 'Arraial Do Cabo'
UPDATE geo_location
SET geolocation_city = 'Arraial Do Cabo'
WHERE geolocation_city = '...Arraial Do Cabo';

-- Remove 'Z-3' from city name 'Colonia Z-3'
UPDATE geo_location
SET geolocation_city = 'Colonia'
WHERE geolocation_city = 'Colonia Z-3';

-- Standardize 'Rio De Janeiro, Rio De Janeiro, Brasil' to 'Rio De Janeiro'
UPDATE geo_location
SET geolocation_city = 'Rio De Janeiro'
WHERE geolocation_city = 'Rio De Janeiro, Rio De Janeiro, Brasil';

-- Normalize variations of 'Sao Joao do Pau Dalho' to a standard form
UPDATE geo_location
SET geolocation_city = 'Sao Joao do Pau Dalho'
WHERE geolocation_city IN ('Sao Joao Do Pau D Alho','Sao Joao Do Pau DAlho','Sao Joao Do Pau D%26apos%3balho');

-- Updating geolocation_state column in geo_location table
-- changing the two codes state names to the corresponding full name
UPDATE geo_location
SET geolocation_state = 
CASE 
    WHEN geolocation_state = 'AC' THEN 'Acre'
    WHEN geolocation_state = 'AL' THEN 'Alagoas'
    WHEN geolocation_state = 'AP' THEN 'Amapa'
    WHEN geolocation_state = 'AM' THEN 'Amazonas'
    WHEN geolocation_state = 'BA' THEN 'Bahia'
    WHEN geolocation_state = 'CE' THEN 'Ceara'
    WHEN geolocation_state = 'DF' THEN 'Distrito Federal'
    WHEN geolocation_state = 'ES' THEN 'Espirito Santo'
    WHEN geolocation_state = 'GO' THEN 'Goias'
    WHEN geolocation_state = 'MA' THEN 'Maranhao'
    WHEN geolocation_state = 'MT' THEN 'Mato Grosso'
    WHEN geolocation_state = 'MS' THEN 'Mato Grosso do Sul'
    WHEN geolocation_state = 'MG' THEN 'Minas Gerais'
    WHEN geolocation_state = 'PA' THEN 'Para'
    WHEN geolocation_state = 'PB' THEN 'Paraiba'
    WHEN geolocation_state = 'PE' THEN 'Pernambuco'
    WHEN geolocation_state = 'PI' THEN 'Piaui'
    WHEN geolocation_state = 'PR' THEN 'Paraná'
    WHEN geolocation_state = 'RJ' THEN 'Rio de Janeiro'
    WHEN geolocation_state = 'RN' THEN 'Rio Grande do Norte'
    WHEN geolocation_state = 'RO' THEN 'Rondonia'
    WHEN geolocation_state = 'RR' THEN 'Roraima'
    WHEN geolocation_state = 'RS' THEN 'Rio Grande do Sul'
    WHEN geolocation_state = 'SC' THEN 'Santa Catarina'
    WHEN geolocation_state = 'SE' THEN 'Sergipe'
    WHEN geolocation_state = 'SP' THEN 'Sao Paulo'
    WHEN geolocation_state = 'TO' THEN 'Tocantins'
    ELSE geolocation_state
END;

-- Replace diacritic characters from geo;ocation_state
UPDATE geo_location
SET geolocation_state = unaccent(geolocation_state);

-- Add new columns shipping_date and shipping_time to the items table.
ALTER TABLE items
ADD COLUMN shipping_date DATE,
ADD COLUMN shipping_time TIME;

-- Update the new columns in the items table with date and time components from the shipping_limit_date column
UPDATE items
SET shipping_date = shipping_limit_date :: DATE,
	shipping_time = shipping_limit_date :: TIME;

-- Remove the original shipping_limit_date column from the items table
ALTER TABLE items
DROP COLUMN shipping_limit_date;

-- orders table
-- Add new date and time columns for each relevant event in the orders table
ALTER TABLE orders
ADD COLUMN purchase_date DATE,
ADD COLUMN purchase_time TIME,
ADD COLUMN approved_date DATE,
ADD COLUMN approved_time TIME,
ADD COLUMN delivered_carrier_date DATE,
ADD COLUMN delivered_carrier_time TIME,
ADD COLUMN delivered_customer_date DATE,
ADD COLUMN delivered_customer_time TIME,
ADD COLUMN estimated_delivery_date DATE,
ADD COLUMN estimated_delivery_time TIME;

-- Update the new columns in the orders table with date and time components from their respective original timestamp columns
UPDATE orders
SET purchase_date = order_purchase_timestamp :: DATE,
	purchase_time = order_purchase_timestamp :: TIME,
	approved_date = order_approved_at :: DATE,
	approved_time = order_approved_at :: TIME,
	delivered_carrier_date = order_delivered_carrier_date :: DATE,
	delivered_carrier_time = order_delivered_carrier_date :: TIME,
	delivered_customer_date = order_delivered_customer_date :: DATE,
	delivered_customer_time = order_delivered_customer_date :: TIME,
	estimated_delivery_date = order_estimated_delivery_date :: DATE,
	estimated_delivery_time = order_estimated_delivery_date :: TIME;

--  Remove the original timestamp columns from the orders table
ALTER TABLE orders
DROP COLUMN order_purchase_timestamp,
DROP COLUMN order_approved_at,
DROP COLUMN order_delivered_carrier_date,
DROP COLUMN order_delivered_customer_date,
DROP COLUMN order_estimated_delivery_date,
DROP COLUMN estimated_delivery_time;

-- products
-- Update the product_category_name in the products table with its English equivalent from the translation table
UPDATE products
SET product_category_name = t.product_category_name_english
FROM translation t
WHERE products.product_category_name = t.product_category_name;

--Delete any rows in the products table where product_category_name is NULL
DELETE FROM products
WHERE product_category_name IS NULL;

--  Update a specific category name in the products table
UPDATE products
SET product_category_name = 'portable_kitchen_and_food_preparers'
WHERE product_category_name ='portateis_cozinha_e_preparadores_de_alimentos';

-- sellers table

-- Remove any diacritic characters from the seller_city field in the sellers table
UPDATE sellers
SET seller_city = unaccent(seller_city);

-- Capitalize the first letter of each word in the seller_city field in the sellers table
UPDATE sellers
SET seller_city = INITCAP(seller_city);

-- orrect specific city names in the sellers table due to various reasons such as spelling errors, abbreviations, or mislabelling
UPDATE sellers
SET seller_city = 'Rio De Janeiro'
WHERE seller_city = '04482255';

UPDATE sellers
SET seller_city = 'Taboao Da Serra'
WHERE seller_city = 'Tabao Da Serra';

UPDATE sellers
SET seller_city = 'Sao Bernardo Do Campo'
WHERE seller_city IN ('Sao Bernardo Do Capo', 'Sbc', 'Sbc/Sp');


UPDATE sellers
SET seller_city = 'Sao Paulo'
WHERE seller_city IN ('Sao Paulo Sp', 'Sao Paulo - Sp', 'Sao Paulop','Sao Paulo / Sao Paulo',
					 'Sao Pauo');

UPDATE sellers
SET seller_city = 'Sao Jose Do Rio Preto'
WHERE seller_city IN ('S Jose Do Rio Preto', 'Sao Jose Do Rio Pret');

UPDATE sellers
SET seller_city = 'Santa Barbara Do Este'
WHERE seller_city IN ('Santa Barbara D''Oeste', 'Santa Barbara D Oeste', 'Santa Barbara D´Oeste');

UPDATE sellers
SET seller_city = 'Sao Jose Do Rio Pardo'
WHERE seller_city = 'Scao Jose Do Rio Pardo';


UPDATE sellers
SET seller_city = 'Sao Jose Dos Pinhais'
WHERE seller_city = 'Sao Jose Dos Pinhas';

UPDATE sellers
SET seller_city = 'Sao Bernardo Do Campo'
WHERE seller_city = 'Ao Bernardo Do Campo';

UPDATE sellers
SET seller_city = 'Belo Horizonte'
WHERE seller_city = 'Belo Horizont';

-- Update the seller_state field in the sellers table with the full name of each Brazilian state, based on the state code
UPDATE sellers
SET seller_state = 
    CASE 
        WHEN seller_state = 'SP' THEN 'Sao Paulo'
        WHEN seller_state = 'RJ' THEN 'Rio de Janeiro'
        WHEN seller_state = 'MG' THEN 'Minas Gerais'
        WHEN seller_state = 'BA' THEN 'Bahia'
        WHEN seller_state = 'PR' THEN 'Parana'
        WHEN seller_state = 'RS' THEN 'Rio Grande do Sul'
        WHEN seller_state = 'PE' THEN 'Pernambuco'
        WHEN seller_state = 'CE' THEN 'Ceara'
        WHEN seller_state = 'PA' THEN 'Para'
        WHEN seller_state = 'MA' THEN 'Maranhao'
        WHEN seller_state = 'SC' THEN 'Santa Catarina'
        WHEN seller_state = 'GO' THEN 'Goias'
        WHEN seller_state = 'PB' THEN 'Paraiba'
        WHEN seller_state = 'ES' THEN 'Espirito Santo'
        WHEN seller_state = 'AM' THEN 'Amazonas'
        WHEN seller_state = 'RN' THEN 'Rio Grande do Norte'
        WHEN seller_state = 'AL' THEN 'Alagoas'
        WHEN seller_state = 'MT' THEN 'Mato Grosso'
        WHEN seller_state = 'SE' THEN 'Sergipe'
        WHEN seller_state = 'MS' THEN 'Mato Grosso do Sul'
        WHEN seller_state = 'RO' THEN 'Rondonia'
        WHEN seller_state = 'TO' THEN 'Tocantins'
        WHEN seller_state = 'PI' THEN 'Piaui'
        WHEN seller_state = 'AP' THEN 'Amapa'
        WHEN seller_state = 'AC' THEN 'Acre'
        WHEN seller_state = 'RR' THEN 'Roraima'
        WHEN seller_state = 'DF' THEN 'Distrito Federal'
        ELSE seller_state
    END;


-- What is the total revenue generated by Olist, and how has it changed over time?

-- Total revenue generated by Olist yearly
SELECT ROUND (CAST(SUM(payment_value) AS NUMERIC), 2) AS Total_revenue
FROM orders
INNER JOIN payments
ON payments.order_id = orders.order_id
WHERE orders.order_status = 'delivered';


-- Total revenue generated by Olist Quarterly
SELECT EXTRACT(YEAR FROM orders.purchase_date) AS Year,
	ROUND (CAST(SUM(payment_value) AS NUMERIC), 2) AS Total_Revenue
FROM orders
INNER JOIN payments
ON payments.order_id = orders.order_id
WHERE orders.order_status = 'delivered'
GROUP BY EXTRACT(YEAR FROM orders.purchase_date);

SELECT EXTRACT(YEAR FROM orders.purchase_date) AS Year,
       CONCAT('Q', EXTRACT(QUARTER FROM orders.purchase_date)) AS Quarter,
       ROUND(CAST(SUM(payment_value) AS NUMERIC), 2) AS Total_Revenue
FROM orders
INNER JOIN payments ON payments.order_id = orders.order_id
WHERE orders.order_status = 'delivered'
GROUP BY EXTRACT(YEAR FROM orders.purchase_date), EXTRACT(QUARTER FROM orders.purchase_date)
ORDER BY EXTRACT(YEAR FROM orders.purchase_date), EXTRACT(QUARTER FROM orders.purchase_date);


-- How many orders were placed on Olist, and how does this vary by month or season?

SELECT EXTRACT(YEAR FROM orders.purchase_date) AS Year,
to_char(orders.purchase_date, 'Month') AS Month,
COUNT(order_id)
FROM orders
WHERE order_status <> 'canceled' OR order_status <> 'unavailable'
GROUP BY 1,2
ORDER BY Year, MIN(orders.purchase_date);

SELECT EXTRACT(YEAR FROM orders.purchase_date) AS Year,
	CONCAT('Q', EXTRACT(QUARTER FROM orders.purchase_date)) AS Quarter,
	COUNT(order_id)
FROM orders
WHERE order_status <> 'canceled' OR order_status <> 'unavailable'
GROUP BY 1,2
ORDER BY 1,MIN(orders.purchase_date);

-- What are the most popular product categories on Olist, 
-- and how do their sales volumes compare to each other?

select *
FROM orders;

SELECT p.product_category_name AS product_category,
	COUNT(*) as Sales_volume
FROM products p
JOIN items i
ON p.product_id = i.product_id
JOIN orders o
ON o.order_id = i.order_id
WHERE o.order_status <> 'canceled' OR o.order_status <> 'unavailable'
GROUP BY product_category
ORDER BY 2 DESC
LIMIT 10;

-- What is the average order value (AOV) on Olist, 
-- and how does this vary by product category or payment method?

SELECT ROUND(AVG(payment_value))
FROM payments;

SELECT payment_type AS Payment_Method,
	ROUND(AVG(payment_value)) AOV
FROM payments
GROUP BY Payment_Method;

SELECT pr.product_category_name AS Product_Category,
	ROUND(AVG(payment_value)) AOV
FROM payments p
JOIN orders o
ON p.order_id = o.order_id
JOIN items i
ON o.order_id = i.order_id
JOIN products pr
ON pr.product_id = i.product_id
GROUP BY Product_Category
ORDER BY AOV DESC;

-- How many sellers are active on Olist, and how does this number change over time?

SELECT COUNT(DISTINCT(seller_id)) AS active_sellers
FROM sellers;

SELECT EXTRACT(YEAR FROM o.purchase_date) AS year,
	COUNT(DISTINCT(s.seller_id)) AS active_sellers
FROM sellers s
JOIN items i
ON s.seller_id = i.seller_id
JOIN orders o
ON o.order_id = i.order_id
WHERE o.order_status <> 'canceled' OR o.order_status <> 'unavailable'
GROUP BY year
ORDER BY year;

--What is the distribution of seller ratings on Olist, and how does this impact sales performance?

WITH total_payment AS(
	SELECT ROUND(SUM(p.payment_value)::NUMERIC,2) AS total
	FROM payments p
    JOIN items i ON p.order_id = i.order_id
    JOIN reviews r ON i.order_id = r.order_id
    JOIN sellers s ON i.seller_id = s.seller_id
)
SELECT r.review_score AS ratings,
	COUNT(DISTINCT s.seller_id) AS seller,
	ROUND(SUM(p.payment_value)::NUMERIC,2) AS total_revenue,
	ROUND((ROUND(SUM(p.payment_value)::NUMERIC, 2) / total.total) * 100)  AS percentage_total_revenue
FROM reviews r
JOIN items i ON i.order_id = r.order_id
JOIN payments p ON p.order_id = r.order_id
JOIN sellers s ON i.seller_id = s.seller_id
CROSS JOIN total_payment AS total
GROUP BY ratings, total.total
ORDER BY ratings ASC;

-- How many customers have made repeat purchases on Olist, 
-- and what percentage of total sales do they account for?
SELECT * FROM orders LIMIT 10; --customer_id

SELECT COUNT(*) AS repeated_customers_purchase
FROM(
	SELECT c.customer_unique_id
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	GROUP BY c.customer_unique_id
	HAVING COUNT(o.order_id) >1
) subquery;

WITH cte1 AS (
	SELECT SUM(p.payment_value) AS sales
	FROM payments p
	JOIN orders o ON p.order_id = o.order_id
	JOIN customers c ON c.customer_id = o.customer_id
	WHERE c.customer_unique_id IN
		(SELECT customer_unique_id
		 FROM
			(SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS purchases
			 FROM customers c
			 JOIN orders o ON o.customer_id = c.customer_id
			 GROUP BY c.customer_unique_id
			 HAVING COUNT(DISTINCT o.order_id) > 1
			) sub
		)
),

cte2 AS (SELECT SUM(p.payment_value) AS total_sales
		 FROM payments p
		 JOIN orders o ON o.order_id = p.order_id
		 JOIN customers c on c.customer_id = o.customer_id

)

SELECT ROUND((cte1.sales/cte2.total_sales):: NUMERIC * 100, 2) AS percentage
FROM cte1
CROSS JOIN cte2


--  What is the average customer rating for products sold on Olist, 
-- and how does this impact sales performance?

SELECT ROUND(AVG(r.review_score):: NUMERIC, 2) AS average_rating
FROM reviews r
JOIN orders o ON r.order_id = o.order_id;

SELECT p.product_category_name AS name,
	ROUND(AVG(r.review_score):: NUMERIC, 2) AS average_rating,
	ROUND(SUM(py.payment_value):: NUMERIC,2) AS sales,
	COUNT(o.order_id) AS total_order
FROM reviews r
JOIN orders o ON r.order_id = o.order_id
JOIN items i ON i.order_id = o.order_id
JOIN products p ON p.product_id = i.product_id
JOIN payments py ON py.order_id = o.order_id
WHERE o.order_status <> 'canceled' OR o.order_status <> 'unavailable'
GROUP BY name
ORDER BY average_rating DESC, sales DESC;

--Observations:

--The categories with the highest average customer ratings are not necessarily those with the highest sales or the most orders. 
--For example, "books_general_interest" has lower average ratings than "cds_dvds_musicals" and "fashion_childrens_clothes", 
--but it far outperforms them in terms of sales and order numbers.

--On the other hand, categories with lower average ratings, like "pc_gamer" and "security_and_services", 
--also tend to have lower sales and order numbers. This could suggest that lower customer satisfaction 
--in these categories is impacting their sales performance negatively.

--Some categories, despite having middling or low ratings, still have high sales and order numbers. 
--"office_furniture", for instance, has a relatively low average rating of 3.52, but its total sales 
--are substantial at 652016.50, with a total of 1788 orders. This could indicate factors other than customer 
--ratings that are contributing to the sales performance of these categories, such as product necessity, 
--lack of alternative vendors, or effective marketing.

-- Query to get the distribution of ratings across all products
SELECT r.review_score AS rating, COUNT(*) AS frequency
FROM reviews r
JOIN orders o ON r.order_id = o.order_id
JOIN items i ON i.order_id = o.order_id
GROUP BY rating
ORDER BY frequency DESC;

-- This indicates that a majority of the products sold on Olist received the highest rating of 5 stars, 
-- suggesting high customer satisfaction. The number of products that received lower ratings (1 to 4 stars) 
--is significantly less, with the 1-star and 4-star ratings being the next most common after the 5-star rating.

-- This distribution is a good indication that, overall, customers are generally satisfied with the 
--products they purchase from Olist. However, there is a notable number of 1-star ratings (the 
--lowest rating), indicating there may be some products or areas of service that could be improved.

--9. What is the average order cancellation rate on Olist, and how does this impact seller performance?
SELECT 
    ROUND((CAST(SUM(CASE WHEN o.order_status = 'canceled' THEN 1 ELSE 0 END) AS FLOAT) 
	 / COUNT(*) * 100):: NUMERIC, 2) AS avg_cancellation_rate
FROM orders o;


-- Calculate average sales for sellers who have had an order cancelled
SELECT 'Sellers with cancelled orders' AS seller_type, AVG(seller_orders) AS average_seller_orders
FROM (
    SELECT s.seller_id, COUNT(DISTINCT o.order_id) AS seller_orders
    FROM orders o
    INNER JOIN items i ON o.order_id = i.order_id
    INNER JOIN sellers s ON i.seller_id = s.seller_id
    WHERE o.order_status = 'canceled'
    GROUP BY s.seller_id
) subquery
UNION ALL
-- Calculate average sales for all sellers
SELECT 'All sellers' AS seller_type, AVG(seller_orders) AS average_seller_orders
FROM (
    SELECT s.seller_id, COUNT(DISTINCT o.order_id) AS seller_orders
    FROM orders o
    INNER JOIN items i ON o.order_id = i.order_id
    INNER JOIN sellers s ON i.seller_id = s.seller_id
    GROUP BY s.seller_id
) subquery;

-- The average order cancellation rate on Olist is 0.63%. This is a relatively low rate, suggesting 
--that the majority of orders placed on Olist are successfully completed.

-- Sellers who have had an order cancelled average about 1.4 orders, while the average for all 
--sellers is about 32.3 orders. This suggests a strong negative impact of order cancellations on 
--seller performance.


--10. What are the top-selling products on Olist, and how have their sales trends changed over time

WITH product_sales AS (
    SELECT pr.product_category_name AS name,
           EXTRACT(YEAR FROM o.purchase_date) AS year,
           COUNT(o.order_id) AS sales
    FROM products pr
    JOIN items i ON pr.product_id = i.product_id
    JOIN orders o ON o.order_id = i.order_id
    GROUP BY name, year
),

top_products AS (
    SELECT name, SUM(sales) AS total_sales,
           RANK() OVER (ORDER BY SUM(sales) DESC) AS rank
    FROM product_sales
    GROUP BY name
    LIMIT 10
)

SELECT ps.name, ps.year, ps.sales
FROM product_sales ps
JOIN top_products tp ON ps.name = tp.name
ORDER BY tp.rank, ps.year;

--The top-selling product categories over the years include "bed_bath_table", 
-- "health_beauty", "sports_leisure", "furniture_decor", and "computers_accessories".

--All of these categories show a year-over-year growth from 2016 to 2017, 
--and most of them also show growth from 2017 to 2018. This indicates a generally increasing demand 
--for these products over the years.

-- The "bed_bath_table" category had the highest sales in 2018, while the "health_beauty" category 
-- had the second highest.

-- However, some categories such as "telephony" and "garden_tools" seem to have stagnant or 
-- declining sales from 2017 to 2018. This could indicate a decrease in demand or increased 
-- competition in these categories.

-- Some categories like "watches_gifts" and "auto" started with relatively lower sales in 
-- 2016 but showed significant growth in the following years.


	























