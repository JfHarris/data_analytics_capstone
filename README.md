# data_analytics_capstone

## General Overview

This is for my capstone project in the Google Data Analytics Career Certificate! I've included the csv, SQL scripts, and R scripts. This repository will be linked in my presentation to limit the appendix length while still allowing code review.

### SQL Files

I wanted to recreate a situation I might encounter in the workplace. In this scenario, someone else imported the csv files years before I started working on it. To do so, I simply imported the csv file using MySQL Workbench and only used the suggested datatypes. For example, the "start_time" and the "started_at" times in the 2019 and 2020 files were imported as text instead of the more appropriate DATETIME datatype. This lead to me needing to convert datatypes in some of the queries.

These files are separated into a 2019, 2020, and joins files. The commands have comments explaining what I was attempting to do so you can have a look at my aggregation and cleaning process.
