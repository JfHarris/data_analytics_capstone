/* **** JOINS and general info gathering from divvy_trips_2019 _q1 and divvy_trips_2020_q1 tables **** */

/* **** Most popular starting and ending stations **** */

-- SELECT from_station_id, COUNT(*) AS num_of_trips_starting_here
-- FROM divvy_trips_2019_q1
-- GROUP BY from_station_id
-- ORDER BY num_of_trips_starting_here DESC
-- LIMIT 20;

-- SELECT start_station_id, COUNT(*) AS num_of_trips_starting_here
-- FROM divvy_trips_2020_q1
-- GROUP BY start_station_id
-- ORDER BY num_of_trips_starting_here DESC
-- LIMIT 1;

-- SELECT to_station_id, COUNT(*) AS num_of_trips_ending_here
-- FROM divvy_trips_2019_q1
-- GROUP BY to_station_id
-- ORDER BY num_of_trips_ending_here DESC
-- LIMIT 1;

-- SELECT end_station_id, COUNT(*) as num_of_trips_ending_here
-- FROM divvy_trips_2020_q1
-- GROUP BY end_station_id
-- ORDER BY num_of_trips_ending_here DESC
-- LIMIT 10;

-- ** JOINS for comparing start and end stations bewtween tables **

-- SELECT from_station_name, COUNT(*) AS num_starting_here
-- FROM divvy_trips_2019_q1
-- LEFT JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY from_station_name
-- UNION
-- SELECT start_station_name, COUNT(*) as num_starting_here
-- FROM divvy_trips_2020_q1
-- LEFT JOIN divvy_trips_2019_q1
-- ON divvy_trips_2020_q1.primary_id = divvy_trips_2019_q1.trip_id
-- GROUP BY start_station_name
-- ORDER BY num_starting_here DESC;

-- SELECT to_station_name, COUNT(*) AS num_ending_here
-- FROM divvy_trips_2019_q1
-- LEFT JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY to_station_name
-- UNION
-- SELECT end_station_name, COUNT(*) as num_ending_here
-- FROM divvy_trips_2020_q1
-- LEFT JOIN divvy_trips_2019_q1
-- ON divvy_trips_2020_q1.primary_id = divvy_trips_2019_q1.trip_id
-- GROUP BY end_station_name
-- ORDER BY num_ending_here DESC;

-- SELECT divvy_trips_2019_q1.from_station_name, COUNT(*) as num_starting_here,
-- 	divvy_trips_2020_q1.start_station_name, COUNT(*) AS num_starting_here
-- FROM divvy_trips_2019_q1
-- CROSS JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY from_station_name, start_station_name
-- ORDER BY num_starting_here DESC;

/* **** Average ride length by member type **** */

-- SELECT SEC_TO_TIME(AVG(ride_length)), usertype
-- FROM divvy_trips_2019_q1
-- GROUP BY usertype
-- ORDER BY usertype;

-- SELECT SEC_TO_TIME(AVG(ride_length)), member_casual
-- FROM divvy_trips_2020_q1
-- GROUP BY member_casual
-- ORDER BY member_casual;

-- SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length)) AS avg_ride_length, divvy_trips_2019_q1.usertype
-- FROM divvy_trips_2019_q1
-- LEFT JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY usertype
-- UNION
-- SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length)) AS avg_ride_length, divvy_trips_2020_q1.member_casual
-- FROM divvy_trips_2020_q1
-- LEFT JOIN divvy_trips_2019_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY member_casual;

/* **** To save the results above as a table, ****
   **** you have two options depending on whether you want static or dynamic info **** */

-- **** Static method ****

-- CREATE TABLE avg_ride_length_by_usertype
-- SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length)) AS avg_ride_length, divvy_trips_2019_q1.usertype
-- FROM divvy_trips_2019_q1
-- LEFT JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY usertype
-- UNION
-- SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length)) AS avg_ride_length, divvy_trips_2020_q1.member_casual
-- FROM divvy_trips_2020_q1
-- LEFT JOIN divvy_trips_2019_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY member_casual;

-- **** Dynamic method allows for updates to database to be applied to this created table ****

-- CREATE VIEW avg_ride_length_by_usertype
-- AS SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length)) AS avg_ride_length, divvy_trips_2019_q1.usertype
-- FROM divvy_trips_2019_q1
-- LEFT JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY usertype
-- UNION
-- SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length)) AS avg_ride_length, divvy_trips_2020_q1.member_casual
-- FROM divvy_trips_2020_q1
-- LEFT JOIN divvy_trips_2019_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY member_casual;
   
/* **** Using JOIN to compare avg ride lengths between the tables **** */

-- SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length))
-- FROM divvy_trips_2019_q1
-- LEFT JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- UNION
-- SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length))
-- FROM divvy_trips_2020_q1
-- LEFT JOIN divvy_trips_2019_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id;

/* **** Determining number of ride by customer type **** */

-- SELECT COUNT(trip_id), usertype
-- FROM divvy_trips_2019_q1 
-- WHERE usertype = 'Customer' OR usertype = 'Subscriber'
-- GROUP BY usertype;

-- SELECT COUNT(ride_id), member_casual
-- FROM divvy_trips_2020_q1 
-- WHERE member_casual = 'member' OR member_casual = 'casual'
-- GROUP BY member_casual;

-- Using JOIN to compare membership type

-- SELECT COUNT(trip_id), usertype AS memberType
-- FROM divvy_trips_2019_q1
-- LEFT JOIN divvy_trips_2020_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY usertype
-- UNION
-- SELECT COUNT(ride_id), member_casual AS memberType
-- FROM divvy_trips_2020_q1
-- LEFT JOIN divvy_trips_2019_q1
-- ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
-- GROUP BY member_casual;

/* **** Finding date with highest number of rides **** 
   **** Easily adapted to show date with lowest number **** 
   **** Also including dates with most returns **** */

-- SELECT start_time, COUNT(*) AS highest_num_of_trips
-- FROM divvy_trips_2019_q1
-- GROUP BY start_time
-- ORDER BY highest_num_of_trips DESC
-- LIMIT 20;

-- SELECT end_time, COUNT(*) AS highest_num_of_returns
-- FROM divvy_trips_2019_q1
-- GROUP BY end_time
-- ORDER BY highest_num_of_returns DESC
-- LIMIT 20;

-- SELECT started_at, COUNT(*) AS highest_num_of_trips
-- FROM divvy_trips_2020_q1
-- GROUP BY started_at
-- ORDER BY highest_num_of_trips DESC
-- LIMIT 20;

-- SELECT ended_at, COUNT(*) AS highest_num_of_returns
-- FROM divvy_trips_2020_q1
-- GROUP BY ended_at
-- ORDER BY highest_num_of_returns DESC
-- LIMIT 20;

/* **** Finding most popular start times by hour ****
   **** Turn start-time from text to datetime ****
   **** Get hour from that datetime **** */

-- ALTER TABLE divvy_trips_2019_q1
-- ADD COLUMN hour_start TIME;
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE divvy_trips_2019_q1
-- SET hour_start = HOUR(CAST(start_time AS TIME));

-- SELECT hour_start, COUNT(*) as trips_started_this_hour
-- FROM divvy_trips_2019_q1
-- GROUP BY hour_start
-- ORDER BY trips_started_this_hour DESC LIMIT 250;