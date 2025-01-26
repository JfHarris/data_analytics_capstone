/*   **** ADDING ride_length column ****  */

USE capstone;
ALTER TABLE divvy_trips_2019_q1
ADD ride_length TIME;

/* **** Inserting calculated values into ride_length column **** 
   **** and setting ride_length to a more easily readable time format HH:MM:SS **** */

SET SQL_SAFE_UPDATES = 0;
UPDATE divvy_trips_2019_q1
SET ride_length = sec_to_time(tripduration * 60);
-- **** CHECK YOUR WORK ****
SELECT ride_length FROM divvy_trips_2019_q1 limit 50;

/* **** Setting Primary Key **** */

ALTER TABLE divvy_trips_2019_q1
ADD primary key (trip_id);

/* **** Creating Day of Week Column ****
   **** Using name of day instead of number **** 
   **** Then getting mode of that column **** */

ALTER TABLE divvy_trips_2019_q1
ADD day_of_week VARCHAR(20);

UPDATE divvy_trips_2019_q1
SET day_of_week = DAYNAME(start_time);
SELECT day_of_week FROM divvy_trips_2019_q1 LIMIT 10;

-- SELECT day_of_week, COUNT(*) as num_of_trips
-- FROM divvy_trips_2019_q1
-- GROUP BY day_of_week
-- ORDER BY day_of_week DESC LIMIT 1;