-- grouped by other fields as well to provide deeper analysis
WITH cte AS(
SELECT society_name, bhk, super_area,
		coalesce(num_of_balcony,0) as num_of_balcony,
        coalesce(num_of_bathrooms,0) as num_of_bathrooms,
        tenant_type, price_per_sqft
FROM data
), percentile_calc AS 
(
SELECT *, PERCENT_RANK() over(PARTITION BY society_name, bhk,num_of_balcony,num_of_bathrooms,tenant_type ORDER BY price_per_sqft) AS pct_rnk
 FROM cte
 ), Per_sqft_Calc as(
SELECT society_name, bhk, num_of_balcony, num_of_bathrooms, tenant_type,
	COUNT(*) AS num_of_apartments,
    ROUND(AVG(super_area),2) AS size, 
    AVG(CASE WHEN pct_rnk <=0.25 THEN price_per_sqft END) AS Range_start_price_psft,
    AVG(CASE WHEN pct_rnk >=0.75 THEN price_per_sqft END) AS Range_end_price_psft,
    ROUND(avg(price_per_sqft),2) AS Suggested_right_price_psft
FROM percentile_calc GROUP BY 1,2,3,4,5
)
SELECT society_name, bhk, num_of_balcony, num_of_bathrooms, tenant_type,
	size,
    ROUND(Range_start_price_psft*size,2) AS Range_Starting,
    ROUND(Range_end_price_psft*size,2) AS Range_Ending,
    ROUND(Suggested_right_price_psft*size,2) AS Suggested_right_price
FROM Per_sqft_Calc
