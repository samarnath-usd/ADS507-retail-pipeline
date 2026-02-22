# Automated Retail Sales Data Pipeline

##  Overview
This project implements a production-ready ELT (Extract, Load, Transform) data pipeline using a retail sales dataset. The pipeline ingests raw data from a CSV file, loads it into a MySQL database, performs transformations using SQL, and generates analytical tables for business insights.

The goal of this project is to simulate a real-world data engineering workflow by separating raw data ingestion, transformation logic, and analytical output layers.

---

##  Architecture

The pipeline follows an ELT architecture:

CSV → raw_sales → clean_sales → (sales_summary, daily_sales, regional_performance)

- Extract: Data is read from CSV  
- Load: Data is inserted into MySQL (raw_sales)  
- Transform: SQL transformations create clean and aggregated tables  

---

##  Project Structure

```
ads507-retail-pipeline/
│
├── data/
│   └── sales_data.csv              # Raw dataset
│
├── sql/
│   ├── create_tables.sql           # Database and raw table creation
│   └── transformations.sql         # Data cleaning and aggregation queries
│
├── scripts/
│   └── load_data.py                # Data ingestion and pipeline execution
│
├── pipeline.log                    # Log file for monitoring
│
└── README.md                      # Project documentation
```

---

##  Dataset

- Source: Kaggle (Superstore Sales Dataset)  
- Format: CSV  
- Size: ~10,000 rows  

Description:
The dataset contains retail transaction data including:
- Order details (order_id, order_date, ship_date)  
- Customer information  
- Product details (category, sub-category)  
- Sales, profit, discount, and quantity  
- Geographic data (city, state, region)  

---

##  How to Run the Pipeline

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

---

##  Output Tables

The pipeline generates the following tables:

### 1. raw_sales
Raw ingested data from CSV  

### 2. clean_sales
Cleaned and transformed dataset with proper date and numeric formats  

### 3. sales_summary
Aggregated sales and profit by region and category  

### 4. daily_sales
Daily total sales trends  

### 5. regional_performance
Overall performance metrics by region  

---

##  Example Use Cases

- Identify top-performing regions  
- Analyze category-wise sales performance  
- Track daily revenue trends  
- Evaluate profit margins across regions  

---

##  Monitoring

Basic monitoring is implemented using Python logging.

Logs are stored in: ```pipeline.log```

Logged events include:
- Pipeline start  
- Data loading  
- Transformation completion  
- Pipeline completion  

---

##  Pipeline Trigger

The pipeline can be scheduled using:

- Windows Task Scheduler  
- Cron jobs (Linux/Mac)  

Example:
Run the pipeline daily to process new data updates  

---

## Reproducibility

This pipeline is fully reproducible:

1. Clone the repository  
2. Run create_tables.sql  
3. Execute load_data.py  

All transformations are defined in SQL and executed programmatically  

---

## Limitations

- Uses a static dataset  
- No real-time ingestion  
- Runs on local MySQL instance  
- Limited error handling  

---

## Future Improvements

- Integrate multiple datasets  
- Add real-time data ingestion  
- Deploy using cloud platforms  
- Add orchestration tools like Airflow  
- Improve monitoring with alerts  

---

## Contributors

- Sanka Amarnath  
- Abhishek Barik

---

##  Conclusion

This project demonstrates a modular and scalable data pipeline using MySQL and Python. It follows best practices in data engineering by separating ingestion, transformation, and analytics layers, making it easy to extend and maintain.