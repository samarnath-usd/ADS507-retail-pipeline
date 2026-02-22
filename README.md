# Automated Retail Sales Data Pipeline

## Overview
This project implements a production-ready ELT (Extract, Load, Transform) data pipeline using a retail sales dataset. The pipeline ingests raw data from CSV files, loads them into a MySQL database, performs transformations using SQL, and generates analytical tables for business insights.

The pipeline also integrates additional datasets (people and returns) to enrich the sales data, enabling more advanced analysis such as return rates and manager-level performance. The overall design follows a layered architecture to simulate a real-world data engineering workflow.

---

## Architecture

The pipeline follows an ELT architecture:

CSV → raw_sales → clean_sales  
          ↓  
       people + returns_data  
          ↓  
       enriched_sales  
          ↓  
      analytics tables  

- Extract: Data is read from CSV files  
- Load: Data is inserted into MySQL (raw tables)  
- Transform: SQL transformations create clean, enriched, and aggregated tables  

---

## Project Structure

##  Project Structure

```
ads507-retail-pipeline/
│
├── data/
│ ├── sales_data.csv # Raw sales dataset
│ ├── people.csv # Regional manager data
│ └── returns_data.csv # Returns information
│
├── sql/
│ ├── create_tables.sql # Database and table creation
│ └── transformations.sql # Data cleaning, joins, and analytics queries
│
├── scripts/
│ └── load_data.py # Data ingestion and pipeline execution
│
├── pipeline.log # Log file for monitoring
│
└── README.md # Project documentation
```
---

## Dataset

- Source: Kaggle (Superstore Sales Dataset)  
- Format: CSV  
- Size: ~10,000 rows  

Additional datasets:
- **people.csv**: Maps regions to regional managers  
- **returns_data.csv**: Indicates whether an order was returned  

Description:
The datasets contain retail transaction data including:
- Order details (order_id, order_date, ship_date)  
- Customer information  
- Product details (category, sub-category)  
- Sales, profit, discount, and quantity  
- Geographic data (city, state, region)  
- Return status and managerial assignments  

---

## How to Run the Pipeline

### Step 1: Create Database and Tables

Run the following SQL file in MySQL Workbench:

```
source sql/create_tables.sql;
```

---

### Step 2: Update Database Credentials

Edit the file:

```
scripts/load_data.py
```

Update:

```
host="localhost",  
user="root",  
password="your_password",  
database="retail_pipeline"  
```

---

### Step 3: Run the Pipeline

```
python scripts/load_data.py
```
This will:
- Load all datasets into MySQL  
- Create clean and enriched tables  
- Generate analytical tables  
---

## Output Tables

### Core Tables

1. **raw_sales**  
   Raw ingested data from CSV  

2. **clean_sales**  
   Cleaned dataset with proper date and numeric formats  

3. **enriched_sales**  
   Joined dataset combining sales, people, and returns data  

---

### Analytical Tables

4. **sales_summary**  
   Aggregated sales and profit by region and category  

5. **daily_sales**  
   Daily total sales trends  

6. **regional_performance**  
   Overall performance metrics by region  

7. **return_analysis**  
   Return rates across regions  

8. **manager_performance**  
   Sales and profit performance by regional manager  

9. **profit_return_impact**  
   Impact of returns on sales and profit  

10. **v_manager_performance**   
    A view combining sales, returns, and manager data to evaluate performance metrics such as net sales and return impact.

---

## Example Use Cases

- Identify high-performing regions and categories  
- Analyze return rates across regions  
- Evaluate performance of regional managers  
- Track daily revenue trends  
- Understand the impact of returns on profitability 

---

##  Monitoring

Basic monitoring is implemented using Python logging.

Logs are stored in: ```pipeline.log```

Logged events include:
- Pipeline start  
- Data loading  
- Transformation completion  
- Pipeline completion  

This provides visibility into pipeline execution and helps identify issues during runtime.

---


## Pipeline Trigger

The pipeline can be scheduled using:

- Windows Task Scheduler  
- Cron jobs (Linux/Mac)  

Example:
Run the pipeline daily to process new or updated data  

---

## Reproducibility

This pipeline is fully reproducible:

1. Clone the repository  
2. Run create_tables.sql  
3. Execute load_data.py  

All transformations are defined in SQL and executed programmatically  

---

## Limitations

- Uses static datasets  
- No real-time ingestion  
- Runs on a local MySQL instance  
- Basic monitoring without alerting  

---

## Future Improvements

- Integrate additional datasets  
- Implement real-time or streaming ingestion  
- Deploy pipeline using cloud platforms (AWS, GCP, Azure)  
- Add orchestration tools such as Apache Airflow  
- Enhance monitoring with alerting and dashboards  


---

## Contributors

- Sanka Amarnath  
- Abhishek Barik

---

## Conclusion

This project demonstrates a modular and scalable data pipeline using MySQL and Python. By incorporating multiple datasets and applying data enrichment through joins, the system provides meaningful business insights. The separation of ingestion, transformation, and analytics layers ensures maintainability and extensibility, making it a strong foundation for real-world data engineering applications.