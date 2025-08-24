# 🛒 Customer Order Purchase Analysis

## 📌 Problem Statement
This project analyzes **customer purchase data** to uncover insights about:
- Sales trends over time  
- Regional performance  
- Product category contributions  
- Customer purchase behavior  

## 🛠 Tools & Techniques
- **SQL** → Data extraction, aggregations, joins  
- **Python (Pandas, Matplotlib)** → Data cleaning, EDA, visualizations  
- **Jupyter Notebook** → End-to-end workflow  

## 📂 Dataset Description
- `order_id` → Unique order identifier  
- `customer_id` → Customer reference ID  
- `product_id` → Product reference ID  
- `product_category` → Type of product (Electronics, Furniture, Clothing, etc.)  
- `order_date` → Date of purchase  
- `quantity` → Units purchased  
- `unit_price` → Price per unit  
- `total_price` → `quantity × unit_price`  
- `region` → Sales region (North, South, East, West)  

## 🔍 SQL Analysis (Sample Queries)
```sql
-- Total revenue by region
SELECT region, SUM(total_price) AS revenue
FROM customer_orders
GROUP BY region
ORDER BY revenue DESC;

-- Monthly sales trend
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(total_price) AS revenue
FROM customer_orders
GROUP BY month
ORDER BY month;

-- Top 5 customers by spend
SELECT customer_id, SUM(total_price) AS total_spent
FROM customer_orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

