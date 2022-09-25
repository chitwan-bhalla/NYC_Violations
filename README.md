# NYC Parking and Camera Violations :traffic_light:
## Data: (https://data.cityofnewyork.us/City-Government/Open-Parking-and-Camera-Violations/nc67-uf89)


### Overview
*This data is a small subset of the full data. Due to the limitation of my MS SQL Serever Express, I can only use a small subset of the data for my analysis. Total record count is 86.5M and I've only used 2M total records.*

My thought behind this dashboard and data clean-up was to present the data to a high-level officer that over sees the financials and validates the data anually. I wanted to present everything in a simple and straight-forward manner so it's easy to consume and share to others. 

### Steps
- Download dataset for the NYC Parking and Camera Violations via Data.gov website
- Review and clean-up data using Notepadd++ and Excel 
- Uploaded data to MSSQL and ran queries to clean-up data (View my update queries in the folder. NYC_Violations_SQLCode.sql)
- Imported data to PowerBi using their built in SQL connection
- Visualization and Dashboard insights: 
    - Stacked area chart explains the count of Violation trended down, resulting in a 97.92% decrease between January 2016 and August 2022.
	- Donut Chart shows that Manhattan accounted for 30.31% of the total count of violation followed by Brooklyn which is 29.19%.
	- I created one visualization using Funnel which shows top 5 states in US that have maximum number of violations, first one being New York with 1.39 Million violations
	- Gauge Chart shows the total number of payments done.
	- Line Chart indicates the top 4 departments with the violations, TRAFFIC had the highest Count of Violation at 1,049,903, followed by DEPARTMENT OF TRANSPORTATION, POLICE DEPARTMENT, and DEPARTMENT OF SANITATION.




