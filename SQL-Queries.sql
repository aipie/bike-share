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
