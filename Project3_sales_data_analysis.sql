CREATE TABLE project_sales(
order_id VARCHAR(50),
order_date DATE,
customer_id VARCHAR(50),
product VARCHAR(100),
quantity INT,
unit_price NUMERIC(10, 2),
shipping_address VARCHAR(255),
payment_method VARCHAR(50),
order_status VARCHAR(50),
tracking_number VARCHAR(100),
items_in_cart INT,
discount_code VARCHAR(50),
referral_source VARCHAR(50),
total_price NUMERIC(12, 2)
);

COPY project_sales (
    order_id, order_date, customer_id, product, quantity, 
    unit_price, shipping_address, payment_method, order_status, 
    tracking_number, items_in_cart, discount_code, referral_source, total_price
)
FROM 'C:/Users/Public/sales.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM project_sales;

-- Product Performance Analysis
SELECT
  product,
  SUM(total_price) AS total_revenue,
  SUM(quantity) AS total_units_sold,
  ROUND(AVG(unit_price), 2) AS average_unit_price
FROM project_sales
GROUP BY product
ORDER BY total_revenue DESC;

-- Marketing Channel Revenue
SELECT 
  referral_source,
  SUM(total_price) AS total_revenue,
  SUM(quantity) AS total_units_sold,
  COUNT(order_id) AS total_orders
 FROM project_sales
 GROUP BY referral_source
 ORDER BY total_revenue DESC;

-- ORDER Status Breakdown
SELECT
  order_status,
  COUNT(order_id) AS total_orders,
  SUM(quantity) AS total_items_processed,
  SUM(total_price) AS financial_impact
FROM project_sales
GROUP BY order_status
ORDER BY total_orders DESC;

-- Discount Code impact Analysis
SELECT
  discount_code,
  COUNT(order_id) AS total_orders,
  ROUND(AVG(items_in_cart), 1) AS avg_items_per_cart,
  ROUND(AVG(total_price), 2) AS avg_order_value
FROM project_sales
GROUP BY discount_code
ORDER BY avg_order_value DESC;


