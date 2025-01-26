/* **** JOINS and general info gathering from divvy_trips_2019 _q1 and divvy_trips_2020_q1 tables **** */

/* **** Most popular starting and ending stations **** */

SELECT from_station_id, COUNT(*) AS num_of_trips_starting_here
FROM divvy_trips_2019_q1
GROUP BY from_station_id
ORDER BY num_of_trips_starting_here DESC
LIMIT 20;

SELECT start_station_id, COUNT(*) AS num_of_trips_starting_here
FROM divvy_trips_2020_q1
GROUP BY start_station_id
ORDER BY num_of_trips_starting_here DESC
LIMIT 1;

SELECT to_station_id, COUNT(*) AS num_of_trips_ending_here
FROM divvy_trips_2019_q1
GROUP BY to_station_id
ORDER BY num_of_trips_ending_here DESC
LIMIT 1;

SELECT end_station_id, COUNT(*) as num_of_trips_ending_here
FROM divvy_trips_2020_q1
GROUP BY end_station_id
ORDER BY num_of_trips_ending_here DESC
LIMIT 10;

-- ** JOINS for comparing start and end stations bewtween tables **

SELECT from_station_name, COUNT(*) AS num_starting_here
FROM divvy_trips_2019_q1
LEFT JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY from_station_name
UNION
SELECT start_station_name, COUNT(*) as num_starting_here
FROM divvy_trips_2020_q1
LEFT JOIN divvy_trips_2019_q1
ON divvy_trips_2020_q1.primary_id = divvy_trips_2019_q1.trip_id
GROUP BY start_station_name
ORDER BY num_starting_here DESC;

SELECT to_station_name, COUNT(*) AS num_ending_here
FROM divvy_trips_2019_q1
LEFT JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY to_station_name
UNION
SELECT end_station_name, COUNT(*) as num_ending_here
FROM divvy_trips_2020_q1
LEFT JOIN divvy_trips_2019_q1
ON divvy_trips_2020_q1.primary_id = divvy_trips_2019_q1.trip_id
GROUP BY end_station_name
ORDER BY num_ending_here DESC;

SELECT divvy_trips_2019_q1.from_station_name, COUNT(*) as num_starting_here,
	divvy_trips_2020_q1.start_station_name, COUNT(*) AS num_starting_here
FROM divvy_trips_2019_q1
CROSS JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY from_station_name, start_station_name
ORDER BY num_starting_here DESC;

/* **** Average ride length by member type **** */

SELECT SEC_TO_TIME(AVG(ride_length)), usertype
FROM divvy_trips_2019_q1
GROUP BY usertype
ORDER BY usertype;

SELECT SEC_TO_TIME(AVG(ride_length)), member_casual
FROM divvy_trips_2020_q1
GROUP BY member_casual
ORDER BY member_casual;

SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length)) AS avg_ride_length, divvy_trips_2019_q1.usertype
FROM divvy_trips_2019_q1
LEFT JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY usertype
UNION
SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length)) AS avg_ride_length, divvy_trips_2020_q1.member_casual
FROM divvy_trips_2020_q1
LEFT JOIN divvy_trips_2019_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY member_casual;
/* RETURNS
17:24:56.0918	Subscriber
10:17:22.2961	Customer
80:09:03.0685	member
219:55:30.4078	casual
*/


/* **** To save the results above as a table, ****
   **** you have two options depending on whether you want static or dynamic info **** */

-- **** Static method ****

CREATE TABLE avg_ride_length_by_usertype
SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length)) AS avg_ride_length, divvy_trips_2019_q1.usertype
FROM divvy_trips_2019_q1
LEFT JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY usertype
UNION
SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length)) AS avg_ride_length, divvy_trips_2020_q1.member_casual
FROM divvy_trips_2020_q1
LEFT JOIN divvy_trips_2019_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY member_casual;

-- **** Dynamic method allows for updates to database to be applied to this created table ****

CREATE VIEW avg_ride_length_by_usertype
AS SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length)) AS avg_ride_length, divvy_trips_2019_q1.usertype
FROM divvy_trips_2019_q1
LEFT JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY usertype
UNION
SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length)) AS avg_ride_length, divvy_trips_2020_q1.member_casual
FROM divvy_trips_2020_q1
LEFT JOIN divvy_trips_2019_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY member_casual;

/* **** Using JOIN to compare avg ride lengths between the tables **** */

SELECT SEC_TO_TIME(AVG(divvy_trips_2019_q1.ride_length))
FROM divvy_trips_2019_q1
LEFT JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
UNION
SELECT SEC_TO_TIME(AVG(divvy_trips_2020_q1.ride_length))
FROM divvy_trips_2020_q1
LEFT JOIN divvy_trips_2019_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id;

/* **** Determining number of ride by customer type **** */

SELECT COUNT(trip_id), usertype
FROM divvy_trips_2019_q1 
WHERE usertype = 'Customer' OR usertype = 'Subscriber'
GROUP BY usertype;
/* RETURNS
341009	Subscriber
6037	Customer
*/

SELECT COUNT(ride_id), member_casual
FROM divvy_trips_2020_q1 
WHERE member_casual = 'member' OR member_casual = 'casual'
GROUP BY member_casual;
/* RETURNS
277407	member
24084	casual
*/

-- Using JOIN to compare membership type

SELECT COUNT(trip_id), usertype AS memberType
FROM divvy_trips_2019_q1
LEFT JOIN divvy_trips_2020_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY usertype
UNION
SELECT COUNT(ride_id), member_casual AS memberType
FROM divvy_trips_2020_q1
LEFT JOIN divvy_trips_2019_q1
ON divvy_trips_2019_q1.trip_id = divvy_trips_2020_q1.primary_id
GROUP BY member_casual;

/* **** Finding date with highest number of rides **** 
   **** Easily adapted to show date with lowest number **** 
   **** Also including dates with most returns **** */

SELECT start_time, COUNT(*) AS highest_num_of_trips
FROM divvy_trips_2019_q1
GROUP BY start_time
ORDER BY highest_num_of_trips DESC
LIMIT 20;
/* RETURNS --- limited to 1 here
# start_time, highest_num_of_trips
'2019-03-27 17:27:33', '6'
*/

SELECT end_time, COUNT(*) AS highest_num_of_returns
FROM divvy_trips_2019_q1
GROUP BY end_time
ORDER BY highest_num_of_returns DESC
LIMIT 20;
/* RETURNS --- limited to 1 here
# end_time, highest_num_of_returns
'2019-01-04 10:00:09', '8'
*/

SELECT started_at, COUNT(*) AS highest_num_of_trips
FROM divvy_trips_2020_q1
GROUP BY started_at
ORDER BY highest_num_of_trips DESC
LIMIT 20;
/* RETURNS --- limited to 1 here
'2020-02-12 08:38:04', '5'
*/

SELECT ended_at, COUNT(*) AS highest_num_of_returns
FROM divvy_trips_2020_q1
GROUP BY ended_at
ORDER BY highest_num_of_returns DESC
LIMIT 20;
/* RETURNS --- limited to 1 here
'2020-01-06 08:11:40', '5'
*/

/* **** Finding most popular start times by hour ****
   **** Turn start-time from text to datetime ****
   **** Get hour from that datetime **** */

ALTER TABLE divvy_trips_2019_q1
ADD COLUMN hour_start TIME;
SET SQL_SAFE_UPDATES = 0;
UPDATE divvy_trips_2019_q1
SET hour_start = HOUR(CAST(start_time AS TIME));

SELECT hour_start, COUNT(*) as trips_started_this_hour
FROM divvy_trips_2019_q1
GROUP BY hour_start
ORDER BY trips_started_this_hour DESC LIMIT 24;
/* RETURNS
00:00:17	48135
00:00:08	37447
00:00:16	37263
00:00:18	27645
00:00:07	26985
00:00:15	20491
00:00:09	17254
00:00:19	16026
00:00:12	15763
00:00:13	15362
00:00:14	15325
00:00:11	13837
00:00:06	12881
00:00:10	11584
00:00:20	9544
00:00:21	6590
00:00:22	4091
00:00:05	3887
00:00:23	2322
00:00:00	1567
00:00:04	970
00:00:01	918
00:00:02	635
00:00:03	524
*/
