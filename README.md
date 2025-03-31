# Project Background
Cyclistic is a bike-share company based in Chicago, with over 5,800 bicycles and 600 docking stations. The current pricing plan includes single-ride passes, full-day passes, and annual memberships. Riders who purchase single-ride or full-day passes are considered casual riders, and riders who purchase the annual membership are Cyclistic members.  Most cyclistic users are likely to ride for leisure, but 30% use the bikes to commute to work each day. Cyclistic has concluded that while flexible pricing attracts more customers, annual members are more profitable. This project analyses trip data to uncover patterns between casual riders and members that can be used to increase membership conversion among casual riders. 

Insights and recommendations are provided on the following key areas:

- **Trip Frequency & Duration** (What are the differences in overall usage volume?)
- **Temporal Usage Patterns** When do casual and member riders use the service? Including peak hours, days of the week, and seasonal trends.
- **Spatial Usage & Route Preferences** Where do casual vs. member riders go? Analysing and comparing station usage, popular routes, and destinations between casual and member riders
- **Ride Type & Contex**t How do trip characteristics differ between casual and member riders? The differences between bikes used, are there more one-way vs round trips? 

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
Following data cleaning, several new features were added in SQL BigQuery

- **Ride length:** To facilitate analysis of ride durations, a new feature, 'ride_length_minutes', was engineered from the existing 'ride_length' column. The 'ride_length' column was originally stored as a string in HH:MM:SS (hours, minutes, seconds) format. To convert these durations into minutes, the following SQL query was executed: A ‘ride_duration_minutes’ was created by taking the ‘ride_length’ column. This was done by a SQL query converting the 'ride_length' column, initially in HH:MM:SS format, to minutes. It split the string by colons, extracted hours, minutes, and seconds, then calculated minutes as (hours * 60) + minutes + (seconds / 60), creating the 'ride_length_minutes' column for numerical analysis.
- **A ‘distance_km’**: column was added using the Haversine formula


The SQL queries used to inspect and clean the data for this analysis can be found here [SQL-Queries](/SQL-Queries.sql)



# Executive Summary
### Overview of Findings
Casual riders exhibited more volatility in growth compared to members, with sharp declines in winter (-47.47% in December, -52.86% in January) and strong rebounds in spring and summer (+93.69% in February, +77.21% in May). Their longer but less frequent rides suggest recreational use, especially in tourist-heavy areas on weekends. Members, on the other hand, took shorter, more frequent trips, primarily for commuting, with peak usage during morning and afternoon rush hours. These results suggest that marketing should focus on seasonal promotions for casual riders, while strengthening commuter-focused incentives for members.

# Insights Deep Dive
**Trip Frequency & Duration**
* **Members are taking more rides than casual riders.**

Overall, members account for the majority of rides, making up **63.7%** of total trips, while casual riders contribute **36.3%**. Casual riders, though making up a smaller proportion, still represent a significant share of trips, suggesting strong demand from occasional users, tourists, or those without memberships. This breakdown will help spot user patterns, adjust bike availability, and develop ways to better convert casual riders into members. 

* **Casual riders were taking longer rides than members.**
  
Ride duration data was highly skewed, with a notable presence of rides with extreme durations. Because of this, I used the median to describe typical ride lengths. This analysis showed that casual riders had a median ride duration of 12.43 minutes, compared to 9 minutes. Casual riders had a bigger difference between their median and average duration than members. This could suggest that casual riders are taking longer and more leisurely rides, whereas members could be using the service for commuting purposes. 

To better understand the differences in ride durations between casual and member riders, I categorised the data into the following duration bins: 1-10 minutes, 11-20 minutes, 21-30 minutes, 31-40 minutes and over 41 minutes. Analysis showed a significant difference between casual riders and member riders. A large proportion of member rides fell between 1-10 minutes (61.77%) and 11-20 minutes (26.62%). Casual riders, while still having a significant portion of short rides, show a more diverse range of ride durations. A larger proportion of casual riders fall in the longer duration bins than members, especially for rides over 20 minutes. 32.21% of casual rides compared to 13.98% of members. 

  
* **Casual Riders have seen faster growth with larger fluctuations.**
  
It can be observed that casual riders have experienced a cumulative growth of **208.29%**, reflecting significant growth over time. In contrast, members achieved a cumulative growth of **76.59%**, which shows a slower growth trajectory.
  
* Casual riders exhibited much more volatility in comparison to members when it came to **month-to-month growth**
  
There is larger volatility in the growth rate, as seen with very high growth in February 2024 **(+93.69%)** and severe negative growth in October 2024 **(-37.08%)**. These extremes indicate that casual riders are more sensitive to certain factors, like weather, which can lead to larger variations in monthly ridership. In contrast, while members also saw a drop in rides during the same months (**-34.72%** in December 2023, **-30.57%** in January 2024, and **-15.24%** in October 2024), their declines were less pronounced than those of casual riders. Members saw a strong rebound in February **(+47.28%)**, which could be a reflection of improved weather that encouraged more rides. From August to October 2024, there was growth but slower and then we saw a decline again in October of **-15.24%**. This could further point to seasonal factors that impact membership growth and ridership. 

![Month-to-Month Growth Analysis](GrowthRate.png)
![Cumulative Growth](Month-to-MonthCumulativeGrowth.png)

### Temporal Usage Analysis:

* The afternoon (3-5 PM) time bin was the most popular for both members and casual riders, with 989,829 rides by members and 556,759 by casual riders. The Morning Rush (6-9 AM) also saw a significant number of rides by members with 729,831 rides clocked. This is over three times higher than casual riders at 230, 235 rides. 
  
* **Casual riders favoured weekend rides.** Saturdays and Sundays saw the most casual rider trips, further reinforcing the idea their trips are more for leisurely purposes, as opposed to work-related. Both electric and classic bikes were equally popular. Weekend ridership among members was lower, suggesting their rides were more work-related than recreational. Members rode more consistently throughout the week, whereas casual riders peaked during weekends, particularly on Saturdays. As for ride duration, for members and casual riders, the longest rides occurred on weekends using classic bikes.

![Weekend Rides](DayofWeek.png)

* July to September, the peak summer months, saw the highest number of rides, while the winter months (December to February) had the lowest usage. Casual riders were most active in summer, accounting for 43.11% of their rides, while members also favoured summer but to a lesser extent (30.26%). Autumn was the second most popular season for both groups, with 30.45% of casual rides and 33.86% of member rides. While winter was the least popular season for both types of riders, a higher proportion of members were still riding in winter than casual riders.  

* While casual riders showed a strong seasonal preference, members' ride distribution was more balanced across summer, autumn, and spring, indicating more consistent year-round usage. 
  
* Casual riders were riding for longer in summer with a median duration of **13.88 minutes**, and further with a median distance of** 1.75 km**. 

![Month Analysis](CasualandMembervsMonth.png)


### Spacial Usage Analysis:
Results from analysing start station data show that ride distribution is spread out, with no single station accounting for a dominant share of rides. For both members and casual riders, the most frequently used stations each represent less than 3% of total rides. However, distinct trends emerge when comparing station preferences between these two groups.

* **Casual riders are frequently riding more around tourist destinations**
  
It was seen that casual riders tend to favour stations near tourist destinations, cultural sites, and recreational areas. Locations such as Streeter Dr & Grand Ave, DuSable Lake Shore & Monroe St/ North Blvd, Michigan Ave & Oak St, and Millennium Park, are among the most utilized. These areas are near well-known landmarks or popular spots, such as Navy Pier, Grant Park, The Magnificent Mile, and Millennium Park. This supports the idea that casual users are more likely to use the service for recreational purposes or social outings rather than daily commuting.

* Among the top 20 stations visited for casual riders, five of them overlap with popular stations for members. The percentage differences range from 15.5% to 36.2%, indicating that casual riders, on average, spend significantly more time per ride at these key stations.

* **The longer median durations at the most popular stations suggest rides are for recreational purposes as opposed to short commutes.**
  
Many of the top stations for casual riders have longer median durations.This suggest that casual rides are primarily for recreational purposes rather than short commutes. Many of these stations are located near Chicago’s major attractions, waterfront areas, and parks, such as Millennium Park **(24.00 min)**, the Shedd Aquarium **(22.12 min)**, and the Adler Planetarium **(24.43 min)**. Notably, stations along DuSable Lake Shore Drive, including Monroe St (24.57 min) and North Blvd (19.18 min), also exhibit extended ride durations, reinforcing the trend of recreational riding. Compared to high-traffic commuter stations, such as Kingsbury St & Kinzie St (8.67 min) and Wells St & Elm St (9.18 min), which are popular for members. These differences highlight how location influences riding behavior.

* **Members rides are concentrated near major transit hubs, business districts, and residential areas.**
  
Among members, the top stations are concentrated near major transit hubs, business districts, and residential areas with strong commuting activity. Stations such as **Kingsbury & Kenzie St**, **Clinton St & Washington Bld**/ **Madison St** / **Jackson Blvd**, rank among the most popular stations. The areas that members seem to be frequenting include: Willis Tower, The West Loop, River North, and The Loop. Many of these places are a combination of businesses, tourism, entertainment and nightlife. The Loop is considered Chicago's central business district (CBD). The West Loop is a former industrial area transformed into a trendy neighbourhood full of restaurants, art galleries, and nightlife. The West Loop is also considered a transit hub, with **Union Station** and **Oglivie Transportation Center**. This makes it an ideal location for work and commuting. 
  
* **Many members are also riding close to universities.**

Among the top stations visited by members, Clinton St & Jackson Blvd, Morgan St & Polk St, and University Ave & 57th St are near universities such as The University of Chicago and University of Illinois Chicago. The popularity of these stations further reinforces the idea that members are primarily commuting.

![Top stations for casual riders](CasualRidersvsStartStation.png)
![Top stations for members](MembersvVStartStation.png)


### Ride Type & Context

_Ride Type & Context (How do trip characteristics differ between casual and member riders?)_
_Differences in the type of bike used (if applicable, e.g., classic vs. e-bike)._
_Are casual rides more likely to be one-way vs. round trips?_
_Are casual trips more dispersed, while member trips are more structured (e.g., more similar start/end locations per trip)?_

* **Electric bikes were the most popular for both members and casual riders.**
  
The three types of bicycles available are: Classic, electric bikes, and electric scooters. Electric bikes were the most popular for members and casual riders, with 1.84 million rides **(49.05%)** taken by members and 1.04 million **(48.21%) **by casual riders. Classic bikes were also widely used, with 1.8 million rides by members and 982,930 by casual riders. Interestingly, electric scooters were much less popular, particularly among members, with only 56,145 rides **(1.49%)**, compared to 81,468 **(3.75%)** rides taken by casual riders. 

* **Casual riders frequently take loop rides, often returning to the same station.**
  
At Streeter Dr & Grand Ave, 16.8% of rides start and end at the same location, while at DuSable Lake Shore Dr & Monroe St, this rises to 20%. Many of these stations are near major tourist destinations, such as Navy Pier and Oak Street Beach, suggesting that casual riders are primarily using the bikes for sightseeing or leisure rather than commuting. In contrast, members overwhelmingly take one-way trips, indicating a stronger focus on transportation rather than recreation.

## Recommendations:
Based on the insights and findings above, the following recommendations have been provided: 

* Many casual riders take recreational trips from stations near tourist attractions, with a significant portion choosing loop rides. Introducing shorter-term membership options, such as a 7-day pass and a monthly pass, could encourage more frequent ridership. The 7-day pass would cater to tourists and short-term visitors. The monthly pass would serve as a stepping stone for frequent casual riders, allowing them to experience membership benefits without committing to an annual plan. Both options have the potential to attract more tourists and short-term visitors while providing a pathway for casual riders to transition into full membership.

* Since many casual riders use Cyclistic bikes for recreational purposes near key landmarks, a  partnership with local attractions or businesses such as gyms, and coffee shops could increase engagement and encourage membership.*

* **The months where growth dropped significantly (December and October) could be targeted for special promotions, re-engagement offers, or referral programs to counteract negative growth.** Rather than scaling back marketing efforts during these downturns, research suggests that companies that continue investing in strategic marketing during economic slowdowns achieve stronger long-term growth. A study by McKinsey & Company found that businesses that maintained or increased their marketing efforts during downturns achieved a 17% compounded growth rate. Applying this principle to ridership trends, targeted marketing campaigns during these off-peak months could mitigate losses and potentially convert casual riders into members. A few campaigns that could be done include:
  * Offering limited-time membership discounts such as multi-ride passes or membership trials in colder months to encourage more sign-ups. 
  * Gamify the experience to encourage membership conversion by introducing challenges such as _Winter Ride Challenge:_ Complete X rides in Winter and get 1 month free of membership.
  * To re-engage casual riders who haven’t taken a trip in a while, targeted incentives such as discounted ride bundles or bonus credits toward membership can encourage them to return. For example, a "$5 off your next ride" offer could encourage to take another ride, while a referral program—where riders earn some kind of reward if their friend signs up—can drive both engagement and conversions.

* Since casual riders are taking longer trips than members, introducing a ride challenge where casual riders who log X number of rides over 20 minutes within a set period unlock a special perk (e.g., a free week of membership).

* Since casual riders are riding more on weekends, weekend exclusive deals such as "Ride Saturday, Get Sunday 50% off" or weekend-challenges such as 'Ride X miles and earn a reward' can boost ridership and potential membership conversion. On top of these, partnership with local cafes or attractions to offer discounts to riders can also boost their enjoyment of the services and convince more riders to convert to members.

* Since the peak season for casual riders is the summer-time, a seasonal marketing campaign that emphasizes convenience, cost savings, and exclusive perks could boost drive engagement and membership conversions. Such examples could include discounted summer ride bundles, membership trial extensions, or ride challenges with rewards. Furthermore, partnering with local festivals and events could also encourage more membership sign-ups.

*For casual riders there was particularly high growth in February, March, and May. This cold be due to a combination of weather, events, and tourism. Targeting these high-growth rate months with specific campaigns could maximise growth during these peak months. One such way would be to tap into the celebration of "Bike Month" in May with local partnerships or riding challenges.


# Assumptions and Caveats:

* Null Values in Station Data: Some data on the start and end stations were missing (nulls). This could affect the analysis of the most popular stations and routes. While this limitation does not drastically alter the main findings, the absence of these data points may slightly skew the results, particularly in identifying optimal areas for membership conversion.

* Generalization of Usage Patterns: We assume that the trip behavior patterns for casual and member riders are broadly representative of typical usage. However, due to the lack of individual-level data, these patterns are inferred from aggregated data and may not fully capture all the nuances of rider behavior.

* Temporal Data Gaps: Some temporal data may be incomplete due to missing timestamps or edge cases in the data collection process. This was accounted for, but stakeholders should note that unusual spikes in activity or non-standard patterns may not be fully explained.

  1,400 rides had recorded durations exceeding 1,000 minutes. While these are likely due to forgotten trip endings, system errors, or other anomalies, they account for a very small proportion of total rides. Because of this, they were not removed from the dataset. However, to minimize their impact on ride duration analysis, median duration was used instead of the mean. 


Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

* Rides with negative or zero durations were removed. From the original table, this resulted in over 117,287 rides, which is about 1.97% of the rides. 
