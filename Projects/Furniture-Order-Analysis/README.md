# 🪑 Furniture Delivery Analysis  

## 📌 Problem Statement  
A furniture company wanted to analyze **order and delivery data** to understand sales performance, profitability, and customer trends.  
Dataset includes **orders, shipping details, customer segments, product categories, and pricing**.  

## 🛠 Tools Used  
- **SQL** → Data extraction, joins, aggregations  
- **Python (Pandas, Matplotlib, Seaborn)** → Data cleaning, analysis, and visualization  
- **Jupyter Notebook** → End-to-end workflow  

## 📂 Dataset Columns  
- **Order_id** – Unique order identifier  
- **Order_date** – Date of order  
- **Ship_mode** – Shipping method (Standard/First Class/Same Day)  
- **Segment** – Customer type (Consumer/Corporate/Home Office)  
- **Country, City, State, Region** – Geography  
- **Category, Sub_Category** – Product details  
- **Cost_Price, List_Price, Quantity, Discount_percent** – Pricing & sales info  

## 🔍 Analysis Performed  
1. **Sales & Profitability**
   - Revenue = List Price × Quantity × (1 - Discount)  
   - Profit = (List Price - Cost Price) × Quantity × (1 - Discount)  

2. **Shipping Mode Performance**
   - Which shipping mode is most profitable?  
   - Which shipping mode leads to delays or losses?  

3. **Customer Segmentation**
   - Revenue contribution by Segment (Consumer/Corporate/Home Office).  

4. **Regional Insights**
   - Which States/Regions drive maximum sales?  
   - Which Cities are least profitable?  

5. **Category & Sub-Category Trends**
   - Top 5 sub-categories by revenue.  
   - Loss-making categories (due to discounts or shipping costs).  

## 📊 Key Visualizations
- Sales by Region (Bar Chart)  
- Discount vs Profitability (Scatter Plot)  
- Ship Mode distribution (Pie Chart)  
- Category-wise Sales (Treemap/Bar Chart)  

## ✅ Insights & Recommendations
- **Standard Class** shipping contributes most orders but lower profit margins.  
- **Same Day** delivery is expensive → consider premium pricing.  
- High discounts on **Office Supplies** reduce overall profitability.  
- Top states (e.g., California, New York) drive majority of sales.  

## 📁 Files in this Folder
- `furniture_analysis.sql` → SQL queries used for exploration.  
- `analysis.ipynb` → Python notebook with cleaning, EDA, and visualizations.  
- `orders.csv` → Small anonymized dataset for reference.  
- `visuals/` → Screenshots of charts & dashboards.  

---

