ALTER TABLE `nimble-volt-436804-j6.bike_share.combined_final_table` 
ADD ride_length_minutes FLOAT 

-- Update the `ride_length_minutes` column in the specified table
UPDATE `nimble-volt-436804-j6.bike_share.combined_final_table`
SET ride_length_minutes = 
  -- Extract hours from `ride_length`, convert to minutes, and multiply by 60
  SAFE_CAST(SPLIT(CAST(ride_length AS STRING), ":")[SAFE_OFFSET(0)] AS INT) * 60 + 
  -- Extract minutes from `ride_length` and convert to an integer
  SAFE_CAST(SPLIT(CAST(ride_length AS STRING), ":")[SAFE_OFFSET(1)] AS INT) + 
  -- Extract seconds from `ride_length`, convert to float, and divide by 60 to get fractional minutes
  SAFE_CAST(SPLIT(CAST(ride_length AS STRING), ":")[SAFE_OFFSET(2)] AS FLOAT64) / 60;

-- Adding distance column 
ALTER TABLE `nimble-volt-436804-j6.bike_share.combined_data`
ADD COLUMN distance FLOAT64;

-- Using the Haversine formula to calculate the distance for each ride 
UPDATE `nimble-volt-436804-j6.bike_share.combined_data`
SET distance_km = 2 * 6371 * ASIN(SQRT(
      POWER(SIN((end_lat - start_lat) * 3.141592653589793 / 180 / 2), 2) +
      COS(start_lat * 3.141592653589793 / 180) * COS(end_lat * 3.141592653589793 / 180) *
      POWER(SIN((end_lng - start_lng) * 3.141592653589793 / 180 / 2), 2)
));

-- Calculating rides for members and casual riders 
SELECT 
  member_casual, count(*) AS ride_count 
FROM
  `nimble-volt-436804-j6.bike_share.combined_final_table`
GROUP BY 
  member_casual 
  
