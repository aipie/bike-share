# Project Background
Cyclistic is a bike-share company based in Chicago, with over 5,800 bicycles and 600 docking stations. Most cyclistic users are likely to ride for leisure, but 30% use the bikes to commute to work each day. Cyclistic has concluded that while flexible pricing attracts more customers, annual members are more profitable. This project analyses trip data to uncover patterns between casual riders and members that can be used to increase membership conversion among casual riders. 

Insights and recommendations are provided on the following key areas:

- **Comparative Trip Frequency and Usage Intensity:** Direct comparison of trip frequency, trip duration, and trip distance between casual and member riders
- **Temporal Usage Analysis:** Comparing time-based usage patterns, including peak hours, days of the week, and seasonal trends.
- **Spacial Usage Analysis:** Analysing and comparing station usage, popular routes, and destinations between casual and member riders.
- **Usage Pattern Variations:** Examining the notable differences between casual and member usage patterns and inferring potential triggers for membership conversion.


The SQL queries used to inspect and clean the data for this analysis can be found here [link].

Targed SQL queries regarding various business questions can be found here [link].


# Data Structure & Initial Checks
I analysed one year's worth of trip data - spanning between November 2023 and October 2024. 

The dataset, made available by Motivate International Inc, comprised 5933712 columns and 13 columns, containing the following information:

- **ride_id:** unique identifier for logged rides
- **rideable_bike:** type of bike (classic, electric、electric scooters)
- **started_at:** the date and time in which the ride started (M/d/yyyy hh:mm)
- **ended_at:** the date and time in which the ride ended (M/d/yyyy hh:mm)
- **start_station_name:** the station name where the ride started
- **start_station_id:** the id for the start station
- **end_station_name:** the station name where the ride ended
- **end_station_id:** the id for the end station
- **start_lat:** the latitude of the starting station
- **start_lng:** the longitude of the starting station
- **end_lat:** the latitude of the ending station
- **end_lng:** the longitude of the ending station
- **member_casual:** the type of rider (member, casual)

The raw data, provided as monthly CSV files, was initially processed in Microsoft Excel to engineer key features. Specifically, I added a 'day_of_week' column for temporal analysis and calculated 'trip_duration' in seconds by subtracting the 'start_time' from the 'end_time'. These monthly files were then combined into a single dataset using Google BigQuery's UNION ALL. 


To ensure the accuracy of ride duration analysis, outliers were identified and addressed. Specifically:
- **Negative or Zero Durations**: Rides with negative or zero durations were removed. From the original table, this resulted in over 117,287 rides, which is about 1.97% of the rides.
- 
Following data cleaning, several new features added in SQL BigQuery

- **Ride length:** To facilitate analysis of ride durations, a new feature, 'ride_length_minutes', was engineered from the existing 'ride_length' column. The 'ride_length' column was originally stored as a string in HH:MM:SS (hours, minutes, seconds) format. To convert these durations into minutes, the following SQL query was executed: A ‘ride_duration_minutes’ was created by taking the ‘ride_length’ column. This was done by a SQL query converting the 'ride_length' column, initially in HH:MM:SS format, to minutes. It split the string by colons, extracted hours, minutes, and seconds, then calculated minutes as (hours * 60) + minutes + (seconds / 60), creating the 'ride_length_minutes' column for numerical analysis.
- **A ‘distance_km’**: column was added using the Haversine formula



# Executive Summary
### Overview of Findings
Explain the overarching findings, trends, and themes in 2-3 sentences here. This section should address the question: "If a stakeholder were to take away 3 main insights from your project, what are the most important things they should know?" You can put yourself in the shoes of a specific stakeholder - for example, a marketing manager or finance director - to think creatively about this section.

[Visualization, including a graph of overall trends or snapshot of a dashboard]

# Insights Deep Dive
**Comparative Trip Frequency and Usage Intensity:**
* **Members are taking more rides than casual riders** 

Overall, members account for the majority of rides, making up **63.7%** of total trips, while casual riders contribute **36.3%**. Casual riders, though making up a smaller proportion, still represent a significant share of trips, suggesting strong demand from occasional users, tourists, or those without memberships. This breakdown will help spot user patterns, adjust bike availability, and develop ways to better convert casual riders into members. 

* **Electric bikes were the most popular for both members and casual riders**
  
The three types of bicycles available are: Classic, and electric bikes, and electric scooters. Electric bikes were the most popular for members and casual riders, with 1.84 million rides taken by members and 1.04 million by casual riders. Classic bikes were also widely used, with 1.8 million rides by members and 982,930 by casual riders. Interestingly, electric scooters were much less popular, particularly among members, with only 56,145 rides, compared to 81,468 rides taken by casual riders.

* **Casual riders were taking longer rides than members** 

Ride duration data was highly skewed, with a notable presence of rides with extreme durations. Because of this, I used the median to describe typical ride lengths. This analysis showed that casual riders had a median ride duration of 12.43 minutes, compared to 9 minutes. Casual riders had a bigger difference between their median and average duration than members. This could suggest that casual riders are taking longer and more leisurely rides, whereas members could be using the service for commuting purposes. 

To better understand the differences in ride durations between casual and member riders, I categorised the data into the following duration bins: 1-10 minutes, 11-20 minutes, 21-30 minutes, 31-40 minutes and over 41 minutes. Analysis showed a significant difference between casual riders and member riders. A large proportion of member rides fell between 1-10 minutes (61.77%) and 11-20 minutes (26.62%). Casual riders, while still having a significant portion of short rides, show a more diverse range of ride durations. A larger proportion of casual riders fall in the longer duration bins than members, especially for rides over 20 minutes. 32.21% of casual rides compared to 13.98% of members. 

* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 1]


### Temporal Usage Analysis:
* The afternoon (3-5 PM) time bin was the most popular for both members and casual riders, with 989,829 rides by members and 556,759 by casual riders. The Morning Rush (6-9 AM) also saw a significant number of rides by members with 729,831 rides clocked. This is over three times higher than casual riders.
  
* **Casual riders favoured weekend rides.**
Saturdays and Sundays saw the most casual rider trips, further reinforcing the idea their trips are more for leisurely purposes, as opposed to work-related. Both electric and classic bikes were equally popular. Weekend ridership among members was lower, suggesting their rides were more work-related than recreational. Members were riding more consistenly throughout the week, whereas casual riders peaked during weekends, particularly on Saturdays. As for ride duration, for members and casual riders, the longest rides occurred on weekends using classic bikes. 

* **Both casual riders and members favoured Summer and Autumn** Summer is the most popular season for casual riders (43.11%) and members (30.26%), and Autumn was the second most popular for both groups of riders (30.45% for casual riders, and 30.26% for members). The least popular season for both riders was winter. Casual riders were riding for longer in summer with a median duration of 13.88 minutes, and further with a median distance of 1.75 km. 
  
[Visualization specific to category 2]


### Spacial Usage Analysis:

* **Casual riders are frequently riding more around tourist destinations** Casual riders, in contrast, tend to favor stations near tourist destinations, cultural sites, and recreational areas. Locations such as Streeter Dr & Grand Ave, DuSable Lake Shore & Monroe St, near Millennium Park, Navy Pier, and Adler Planetarium, are among the most utilized. This supports the idea that casual users are more likely to use the service for recreational purposes or social outings rather than daily commuting. The longer median durations at these stations suggest rides are for recreational purposes as opposed to short commutes.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

Results show that ride distribution is spread out, with no single station accounting for a dominant share of rides. For both members and casual riders, the most frequently used stations each represent less than 3% of total rides. However, distinct trends emerge when comparing station preferences between these two groups.
Among members, the top stations are concentrated near major transit hubs, business districts, and residential areas with strong commuting activity. Stations such as Kingsbury & Kenzie St, Clinton St & Washington Bld/ Madison St / Jackson Blvd, rank among the most popular stations. These are in Chicago’s central business district, The Loop. Other areas that members seem to be frequenting include: Willis Tower, The West Loop, and River North. These areas are home to many businesses including Google Chicago and Linkedin. This suggests that members frequently use the service for commuting needs and other routine travel needs. Among the top most travelled stations for members, 



[Visualization specific to category 3]


### Category 4:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 4]

## Recommendations:
Based on the insights and findings above, we would recommend the [stakeholder team] to consider the following: 

* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  
* Specific observation that is related to a recommended action. **Recommendation or general guidance based on this observation.**
  


# Assumptions and Caveats:

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

* Assumption 1 (ex: missing country records were for customers based in the US, and were re-coded to be US citizens)
  
* Assumption 1 (ex: data for December 2021 was missing - this was imputed using a combination of historical trends and December 2020 data)
  
* Assumption 1 (ex: because 3% of the refund date column contained non-sensical dates, these were excluded from the analysis)
