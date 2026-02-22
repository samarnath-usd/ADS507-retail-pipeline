import pandas as pd
import mysql.connector
import logging

# ---------------- LOGGING SETUP ----------------
logging.basicConfig(
    filename='pipeline.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

logging.info("Pipeline started")

# ---------------- LOAD CSV ----------------
df = pd.read_csv("data/sales_data.csv", encoding="latin1")
logging.info("CSV loaded successfully")

# ---------------- DB CONNECTION ----------------
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="your_password",
    database="retail_pipeline"
)

cursor = conn.cursor()
logging.info("Connected to MySQL")

# ---------------- INSERT DATA ----------------
cursor.executemany("""
INSERT INTO raw_sales VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
""", df.values.tolist())

conn.commit()
logging.info("Data inserted into raw_sales")

# ---------------- RUN TRANSFORMATIONS ----------------
with open("sql/transformations.sql", "r") as file:
    sql_commands = file.read().split(";")

for command in sql_commands:
    if command.strip():
        cursor.execute(command)

conn.commit()
logging.info("Transformations completed")

cursor.close()
conn.close()

logging.info("Pipeline finished successfully")