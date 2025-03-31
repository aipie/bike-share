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

-- Adding season column 
ALTER TABLE `nimble-volt-436804-j6.bike_share.combined_data`
ADD COLUMN season STRING;
  
UPDATE `nimble-volt-436804-j6.bike_share.combined_final_table`
SET season = CASE
    WHEN EXTRACT(MONTH FROM started_at) IN (12, 1, 2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM started_at) IN (3, 4, 5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM started_at) IN (6, 7, 8) THEN 'Summer'
    WHEN EXTRACT(MONTH FROM started_at) IN (9, 10, 11) THEN 'Autumn'
    ELSE 'Unknown'
  END
WHERE TRUE;

-- Adding month column 
ALTER TABLE `nimble-volt-436804-j6.bike_share.combined_data`
ADD COLUMN month STRING;
  
UPDATE `nimble-volt-436804-j6.bike_share.combined_data`
SET month = FORMAT_TIMESTAMP('%B', TIMESTAMP(started_at));

-- Adding time bin column
ALTER TABLE `nimble-volt-436804-j6.bike_share.combined_data`
ADD COLUMN time_bin STRING;

UPDATE `nimble-volt-436804-j6.bike_share.combined_data`
SET time_bin = CASE 
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 6 AND 9 THEN 'Morning Rush (6-9 AM)'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 9 AND 11 OR EXTRACT(HOUR FROM started_at) = 12 THEN 'Mid-Morning (9 AM-12 PM)' 
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 13 AND 14 THEN 'Lunch Rush (1-2 PM)' 
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 15 AND 17 THEN 'Afternoon (3-5 PM)' 
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 18 AND 19 THEN 'Evening Rush (6-7 PM)'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 20 AND 23 THEN 'Night (8-11 PM)' 
    WHEN (EXTRACT(HOUR FROM started_at) BETWEEN 0 AND 5 OR EXTRACT(HOUR FROM started_at) = 23) THEN 'Night (12-6 AM)' 
    ELSE 'Unknown Time' 
  END
  WHERE TRUE;


-- Calculating median and average durations and distances for members and casual riders 
SELECT
  member_casual, COUNT(*) AS ride_count, 
 APPROX_QUANTILES(ride_length_minutes_1, 2)[OFFSET(1)] AS median_duration,  -- 50th percentile (median)
 AVG(ride_length_minutes_1) AS average_duration, 
 APPROX_QUANTILES(distance_km, 2)[OFFSET(1)] AS median_distance,  -- 50th percentile (median)
 AVG(distance_km) AS average_distance
FROM `nimble-volt-436804-j6.bike_share.combined_final_table`
GROUP BY
`member_casual


