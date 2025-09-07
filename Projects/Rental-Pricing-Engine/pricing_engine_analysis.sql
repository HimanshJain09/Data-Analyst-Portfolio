-- percentile rank of each property's price within its group.
-- this helps us identify the bottom 25% and top 25% of prices.
with percentile_calc as (select *, percent_rank() over(partition by society_name, bhk order by price_per_sqft) as pct_rnk from data), 
Per_sqft_Calc as(
select society_name, bhk, 
	ROUND(avg(super_area),2) as size, 
    AVG(CASE WHEN pct_rnk <=0.25 THEN price_per_sqft END) as Range_start_price_per_sqft,
    AVG(CASE WHEN pct_rnk >=0.75 THEN price_per_sqft END) as Range_end_price_per_sqft,
    ROUND(AVG(price_per_sqft),2) as Suggested_right_price_per_sqft
FROM percentile_calc group by 1,2 order by 1,2
),
cte_3 as(
SELECT society_name, bhk,
	size,
    ROUND(Range_start_price_per_sqft*size,2) AS Range_Starting,
    ROUND(Range_end_price_per_sqft*size,2) AS Range_Ending,
    ROUND(Suggested_right_price_per_sqft*size,2) AS Suggested_right_price
FROM Per_sqft_Calc)
-- Anomaly Detection
SELECT society_name, bhk, size, Range_Starting, Range_Ending, Suggested_right_price,
		case when 
			Next_bhk_Range_st_price <= Range_Ending 
            then 'Yes' else 'No' 
            end as Anomaly, 
		Next_bhk_Range_st_price
FROM (SELECT society_name, bhk,
			size,
			Range_Starting,
			Range_Ending,
			Suggested_right_price,
			LEAD(Range_Starting) OVER(PARTITION BY society_name ORDER BY bhk ASC) as Next_bhk_Range_st_price
FROM cte_3) a