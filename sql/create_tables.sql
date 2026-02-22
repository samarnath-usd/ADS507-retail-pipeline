CREATE DATABASE IF NOT EXISTS retail_pipeline;
USE retail_pipeline;

-- Sales table
CREATE TABLE raw_sales (
    order_id VARCHAR(50),
    order_date VARCHAR(50),
    ship_date VARCHAR(50),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales VARCHAR(50),
    quantity VARCHAR(50),
    discount VARCHAR(50),
    profit VARCHAR(50)
);

-- people table
CREATE TABLE people (
    person VARCHAR(100),
    region VARCHAR(50)
);

-- returns table
CREATE TABLE returns_data (
    returned VARCHAR(10),
    order_id VARCHAR(50)
);