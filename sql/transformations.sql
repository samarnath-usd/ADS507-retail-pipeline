DROP TABLE IF EXISTS clean_sales;
DROP TABLE IF EXISTS enriched_sales;
DROP TABLE IF EXISTS sales_summary;
DROP TABLE IF EXISTS daily_sales;
DROP TABLE IF EXISTS regional_performance;
DROP TABLE IF EXISTS return_analysis;
DROP TABLE IF EXISTS manager_performance;
DROP TABLE IF EXISTS profit_return_impact;
DROP TABLE IF EXISTS v_manager_performance;
USE retail_pipeline;

-- ==============================
-- 1. CLEAN LAYER
-- ==============================

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


-- ==============================
-- 2. ENRICHED LAYER (JOINS)
-- ==============================
CREATE TABLE enriched_sales AS
SELECT
    cs.*,
    p.person AS regional_manager,
    r.returned
FROM clean_sales cs
LEFT JOIN people p
    ON cs.region = p.region
LEFT JOIN returns_data r
    ON cs.order_id = r.order_id;

-- ==============================
-- 3. BASIC ANALYTICS
-- ==============================
CREATE TABLE sales_summary AS
SELECT 
    region, 
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit) / SUM(sales) AS profit_ratio
FROM clean_sales
GROUP BY region, category;

CREATE TABLE daily_sales AS
SELECT 
    DATE(order_date) AS order_day,
    SUM(sales) AS daily_sales
FROM clean_sales
GROUP BY order_day;

CREATE TABLE regional_performance AS
SELECT 
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit) / SUM(sales) AS profit_ratio
FROM clean_sales
GROUP BY region;


-- ==============================
-- 4. ADVANCED ANALYTICS
-- ==============================

-- Return rate by region
CREATE TABLE return_analysis AS
SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS returned_orders,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS return_rate
FROM enriched_sales
GROUP BY region;

-- Manager performance
CREATE TABLE manager_performance AS
SELECT
    regional_manager,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM enriched_sales
GROUP BY regional_manager;

-- Profit impact of returns
CREATE TABLE profit_return_impact AS
SELECT
    returned,
    AVG(profit) AS avg_profit,
    AVG(sales) AS avg_sales
FROM enriched_sales
GROUP BY returned;

-- ==============================
-- 5. VIEW (BUSINESS METRIC)
-- ==============================
CREATE VIEW v_manager_performance AS
SELECT 
    p.person AS manager_name,
    cs.region,
    SUM(cs.sales) AS gross_sales,

    -- Net sales excluding returned orders
    SUM(CASE 
        WHEN r.returned = 'Yes' THEN 0 
        ELSE cs.sales 
    END) AS net_sales,

    -- Total number of returned orders
    COUNT(DISTINCT r.order_id) AS total_returns

FROM clean_sales cs
LEFT JOIN people p 
    ON cs.region = p.region
LEFT JOIN returns_data r 
    ON cs.order_id = r.order_id

GROUP BY p.person, cs.region;