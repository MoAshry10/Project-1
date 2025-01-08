--View
CREATE VIEW 
      all_years AS WITH all_years AS (
SELECT * FROM [2018]
UNION 
SELECT * FROM [2019]
UNION 
SELECT * FROM [2020]
)

SELECT
	ay.*,
	ms.Discount,
      mc.cost
FROM 
	all_years ay
LEFT JOIN 
      market_segment ms
ON 
      ay.market_segment = ms.market_segment
LEFT JOIN 
      meal_cost mc
ON 
      ay.meal = mc.meal;
-- Q1: What is the profit percentage for each month across all years?
USE 
      hotel
SELECT
      arrival_date_year AS year ,
      arrival_date_month AS month,
      ROUND(SUM((adr*(stays_in_weekend_nights+stays_in_week_nights+cost))*(1-Discount)),0) AS total_revenue ,
      ROUND(SUM((stays_in_weekend_nights+stays_in_week_nights)*cost),0) AS total_cost ,
      ROUND((SUM((adr*(stays_in_weekend_nights+stays_in_week_nights+cost))*(1-Discount))-SUM((stays_in_weekend_nights+stays_in_week_nights)*cost))/SUM((stays_in_weekend_nights+stays_in_week_nights)*cost),0) *100 AS profit_percentage
FROM 
      all_years 
GROUP BY 
      arrival_date_year ,
      arrival_date_month
ORDER BY 
      arrival_date_year;
----------------------------------------------------------------------------------------
-- Q2: Which meals and market segments (e.g., families, corporate clients, etc.) contribute the most to the total revenue for each hotel annually?
USE 
      hotel 
SELECT 
      arrival_date_year AS year,
      meal,
      market_segment,
      SUM((adr*(stays_in_weekend_nights+stays_in_week_nights+cost))*(1-Discount)) AS total_revenue
FROM 
      all_years
GROUP BY 
      arrival_date_year,
      meal,
      market_segment 
ORDER BY 
      total_revenue DESC ;
----------------------------------------------------------------------------------------
-- Q3: How does revenue compare between public holidays and regular days each year?
USE 
      hotel 
SELECT 
      arrival_date_year AS year,
      ROUND(SUM(adr*stays_in_week_nights),0)AS regular_nights_revenue,
      ROUND(SUM(adr*stays_in_weekend_nights),0) AS holiday_nights_revenue
FROM 
      all_years
GROUP BY 
      arrival_date_year 
ORDER BY 
      year DESC ;
----------------------------------------------------------------------------------------
-- Q4: What are the key factors (e.g., hotel type, market type, meals offered, number of nights booked) significantly impact hotel revenue annually?
USE 
      hotel 
SELECT 
      meal,
      market_segment, 
      ROUND(SUM(adr*(stays_in_weekend_nights+stays_in_week_nights)),0) AS total_revenue
FROM 
      all_years 
GROUP BY 
      meal,
      market_segment
ORDER BY
      total_revenue DESC;
----------------------------------------------------------------------------------------
-- Q5: Based on stay data, what are the yearly trends in customer preferences for room types (e.g., family rooms vs. single rooms), and how do these preferences influence revenue?
USE
      hotel
SELECT 
      reserved_room_type AS room_type,
      COUNT(*) AS total_bookings,
      SUM((stays_in_week_nights+stays_in_weekend_nights)*adr) AS total_revenue
FROM 
      all_years
GROUP BY 
      reserved_room_type
ORDER BY 
      total_revenue DESC,
      room_type ;




         
