# Q1 Customer Repeat Purchases
with cte as (
select customer_id,order_id,
lead(order_id) over(partition by customer_id order by order_date asc) as second_order_id,
(lead(order_date) over(partition by customer_id order by order_date asc) - order_date) as date_diff
 from df_ucda
 )
 select * from cte where date_diff < 30;
 
 #Q2 Products with Similar prices
 select df_1.product_id, df_1.unit_price, df_2.unit_price, 
 round(((abs(df_1.unit_price - df_2.unit_price))*100/df_1.unit_price),2) as percent_price_diff
 from df_ucda df_1 join df_ucda df_2
 on df_1.product_category = df_2.product_category
 and ((abs(df_1.unit_price - df_2.unit_price))/df_1.unit_price) < 0.1;
 
 #Q3 Top Customers by Region
 with regional_cust_sales as (
 select region, customer_id, total_price, 
 row_number() over(partition by region order by total_price desc) as rnk from df_ucda
 )
 select * from regional_cust_sales where rnk<=3;
 
 #Q4 Running total sales by Category
 select product_category, order_date, total_price, 
 round(sum(total_price) over(partition by product_category order by order_date asc),2) as running_total
 from df_ucda