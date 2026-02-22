import pandas as pd
import mysql.connector

df = pd.read_csv("sales_data.csv",encoding="latin1")

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root123",
    database="retail_pipeline"
)

cursor = conn.cursor()

for _, row in df.iterrows():
    cursor.execute("""
    INSERT INTO raw_sales VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, tuple(row))

conn.commit()