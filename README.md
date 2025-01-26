# data_analytics_capstone

## General Overview

This is for my capstone project in the Google Data Analytics Career Certificate! I've included the csv, SQL scripts, and R scripts. This repository will be linked in my presentation to limit the appendix length while still allowing code review.

### SQL Files

I wanted to recreate a situation I might encounter in the workplace. In this scenario, someone else imported the csv files years before I started working on it. To do so, I simply imported the csv file using MySQL Workbench and only used the suggested datatypes. For example, the "start_time" and the "started_at" times in the 2019 and 2020 files were imported as text instead of the more appropriate DATETIME datatype. This lead to me needing to convert datatypes in some of the queries.

These files are separated into a 2019, 2020, and joins files. The commands have comments explaining what I was attempting to do so you can have a look at my aggregation and cleaning process.

install.packages("tidyverse")
library(tidyverse)
library(dplyr)
str(divvy_Trips_2019_Q1)
str(divvy_Trips_2020_Q1)

# column_names <- c("trip_id", "start_time", "end_time", "from_station_name",

                  "to_station_name", "usertype", "tripduration")

# colnames(divvy_trips_combined) <- column_names)

# divvy_trips_combined <- data.frame(column_names)

# divvy_Trips_2020_Q1 <- divvy_Trips_2020_Q1[, -which(names(divvy_Trips_2020_Q1) == "rideable_type")]

# colnames(divvy_Trips_2020_Q1)[which(names(divvy_Trips_2020_Q1) == "ride_id")] <- "trip_id"

# colnames(divvy_Trips_2020_Q1)[which(names(divvy_Trips_2020_Q1) == "started_at")] <- "start_time"

# colnames(divvy_Trips_2020_Q1)[which(names(divvy_Trips_2020_Q1) == "ended_at")] <- "end_time"

# colnames(divvy_Trips_2020_Q1)[which(names(divvy_Trips_2020_Q1) == "start_station_name")] <- "from_station_name"

# colnames(divvy_Trips_2020_Q1)[which(names(divvy_Trips_2020_Q1) == "end_station_name")] <- "to_station_name"

# colnames(divvy_Trips_2020_Q1)[which(names(divvy_Trips_2020_Q1) == "member_casual")] <- "usertype"

divvy_trips_combined$tripduration
divvy_trips_combined <- divvy_trips_combined %>% mutate(tripduration = end_time - start_time)
divvy_Trips_2019_Q1$trip_id<-as.character(divvy_Trips_2019_Q1$trip_id)
divvy_trips_combined <- full_join(divvy_Trips_2019_Q1, divvy_Trips_2020_Q1, by = "trip_id")
