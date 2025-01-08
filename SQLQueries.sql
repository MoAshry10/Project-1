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
   total_revenue DESC, room_type ;
