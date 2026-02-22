USE retail_pipeline;

-- Clean layer
CREATE TABLE clean_sales AS
SELECT
    order_id,
    STR_TO_DATE(order_date, '%m/%d/%Y') AS order_date,
    STR_TO_DATE(ship_date, '%m/%d/%Y') AS ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    CAST(sales AS DECIMAL(10,2)) AS sales,
    CAST(quantity AS SIGNED) AS quantity,
    CAST(discount AS DECIMAL(5,2)) AS discount,
    CAST(profit AS DECIMAL(10,2)) AS profit
FROM raw_sales;

-- Aggregations
CREATE TABLE sales_summary AS
SELECT region, category,
       SUM(sales) total_sales,
       SUM(profit) total_profit,
       SUM(profit)/SUM(sales) profit_ratio
FROM clean_sales
GROUP BY region, category;

CREATE TABLE daily_sales AS
SELECT DATE(order_date) order_day,
       SUM(sales) daily_sales
FROM clean_sales
GROUP BY order_day;

CREATE TABLE regional_performance AS
SELECT region,
       SUM(sales) total_sales,
       SUM(profit) total_profit,
       SUM(profit)/SUM(sales) profit_ratio
FROM clean_sales
GROUP BY region;