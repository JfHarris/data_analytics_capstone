/*   **** ADDING tripduration column ****  */
USE capstone;
ALTER TABLE divvy_trips_2020_q1
ADD tripduration TEXT;
UPDATE divvy_trips_2020_q1
SET tripduration = CAST(ended_at AS DATETIME) - CAST(started_at AS DATETIME);
SELECT tripduration FROM divvy_trips_2020_q1 LIMIT 10;

/*   **** ADDING ride_length column ****  */

ALTER TABLE divvy_trips_2020_q1
ADD ride_length TIME;

/* **** Inserting calculated values into ride_length column **** 
   **** and setting ride_length to a more easily readable time format HH:MM:SS **** */

SET SQL_SAFE_UPDATES = 0;
UPDATE divvy_trips_2020_q1
SET ride_length = sec_to_time(tripduration * 60);
-- **** CHECK YOUR WORK ****
SELECT ride_length FROM divvy_trips_2020_q1 limit 50;

/* **** Adding primary_id column and setting Primary Key **** */

ALTER TABLE divvy_trips_2020_q1
ADD COLUMN primary_id INT(75) AUTO_INCREMENT PRIMARY KEY;
SELECT primary_id FROM divvy_trips_2020_q1 ORDER BY primary_id DESC LIMIT 10;

/* **** Creating Day of Week Column ****
   **** Using name of day instead of number **** 
   **** Then getting mode of that column **** */

ALTER TABLE divvy_trips_2020_q1
ADD day_of_week VARCHAR(20);

UPDATE divvy_trips_2020_q1
SET day_of_week = DAYNAME(started_at);
SELECT day_of_week FROM divvy_trips_2019_q1 LIMIT 10;

-- SELECT day_of_week, COUNT(*) as num_of_trips
-- FROM divvy_trips_2020_q1
-- GROUP BY day_of_week
-- ORDER BY day_of_week DESC LIMIT 1;