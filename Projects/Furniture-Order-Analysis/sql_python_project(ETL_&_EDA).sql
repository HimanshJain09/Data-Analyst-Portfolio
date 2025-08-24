#find top 10 highest revenue generating products
select product_id, sum(sales_price) as sales from df_orders group by 1 order by sales desc limit 10;

#find top 5 highest selling products in each region
with cte as(
select region,product_id, sum(sales_price) as sales 
from df_orders 
group by 1,2 order by sales desc
)
, cte_2 as (
select region, product_id, sales, rank() over(partition by region order by sales desc) rnk
from cte)
select region, product_id, sales from cte_2 where rnk<=5;

#find month over month growth comparison for 2022 and 2023 sales eg jan 2022 vs jan 2023
with cte as (
select year(order_date) as order_year, month(order_date) order_month,
sum(sales_price) as sales from df_orders group by 1,2
)
select order_month,
sum(case when order_year = 2022 then sales end) as 2022_sales,
sum(case when order_year = 2023 then sales end) as 2023_sales
from cte
group by 1
order by 1 asc;
#for each category which month had highest sales
with cte as (
select category, date_format(order_date, '%Y%m') order_year_month, sum(sales_price) as sales
from df_orders
group by 1,2
), cte_2 as(
select category, order_year_month, sales, rank() over(partition by category order by sales desc) as rnk
from cte
)
select category, order_year_month, sales from cte_2 where rnk = 1;
#which sub category had highest growth by profit in 2023 compare to 2022
with cte as (
select year(order_date) as order_year, sub_category, sum(sales_price) as yearly_sales from df_orders
group by 1,2 order by 1,2
)
select t1.sub_category, (t2.yearly_sales - t1.yearly_sales)*100 / t1.yearly_sales as profit_growth_percent from cte as t1 inner join cte as t2 
on t1.order_year = t2.order_year - 1
and t1.sub_category = t2.sub_category
order by 2 desc
limit 1