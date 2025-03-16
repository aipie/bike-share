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

# Executive Summary
### Overview of Findings
Explain the overarching findings, trends, and themes in 2-3 sentences here. This section should address the question: "If a stakeholder were to take away 3 main insights from your project, what are the most important things they should know?" You can put yourself in the shoes of a specific stakeholder - for example, a marketing manager or finance director - to think creatively about this section.

[Visualization, including a graph of overall trends or snapshot of a dashboard]

# Insights Deep Dive
### Comparative Trip Frequency and Usage Intensity
Overall, members account for the majority of rides, making up 63.7% of total trips, while casual riders contribute 36.3%. Casual riders, though making up a smaller proportion, still represent a significant share of trips, suggesting strong demand from occasional users, tourists, or those without memberships. This breakdown will help spot user patterns, adjust bike availability, and develop ways to better convert casual riders into members. 


* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 1]


### Category 2:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

[Visualization specific to category 2]


### Category 3:

* **Main insight 1.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 2.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 3.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.
  
* **Main insight 4.** More detail about the supporting analysis about this insight, including time frames, quantitative values, and observations about trends.

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
