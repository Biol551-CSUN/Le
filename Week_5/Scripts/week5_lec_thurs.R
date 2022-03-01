### Today we are learning how to lubridate data ###
### Created by: Vivian Vy Le ###
### Updated: 2022-02-24 ###

#### load libraries ####
library(tidyverse)
library(here)
library(lubridate) #package for dealing with date and time

### load data ###
Depthdata <- read_csv(here("Week_5", "Data","DepthData.csv"))
CondData <- read_csv(here("Week_5","Data","CondData.csv"))

### view data###
glimpse(Depthdata)
glimpse(CondData)
view(Depthdata)
view(CondData)

#### viewing time ####
now() #views date and time in current location in 24hr
now("EST") #views date and time in a specific time zone in 24hr
today() #views date
today(tzone = "GMT")
am(now()) #asks the question if time currently is morning and the answer is either True or False
leap_year(now()) #asks the question if this current year is a leap year and the answer is either True or False
ymd("2022-02-24") #dates are considered characters
mdy("02/24/2022") #month, day, year
mdy("February 24 2022")  #month spelled out, day, year
dmy("24/02/2022") #needs to be day month year
ymd_hms("2022-02-24 10:22:20 PM") #year, month, day, time in 24hr
mdy_hms("02/24/2022, 22:22:20 PM")
mdy_hm("February 24 2022, 10:22 PM")

#making a character string
datetimes<-c("02/24/2022 22:22:20",
             "02/25/2022 11:21:10",
             "02/26/2022 8:01:52")
datetimes<-mdy_hms(datetimes) #converts the dates and times in the mdy_hms format
month(datetimes) #gives out the months from the dataset
month(datetimes, label = TRUE, abbr = FALSE) #spells out the months
wday(datetimes, label = TRUE) #extract day of week
hour(datetimes)
minute(datetimes)
second(datetimes)

### adding dates and times ####
datetimes +hours(4) #this adds 4 hours to the dataset, hours is spelled with an 's' for this function
#hour() extracts the hour component
#hours() is used to add hours

datetimes + days(2) #adds 2 days to dataset

### rounding dates ###
round_date(datetimes, "minute") #round to nearest minute
round_date(datetimes, "5 mins") #round to nearest 5 minutes

#### think pair share ####
CondData_time <-CondData %>%
  mutate(datetime = mdy_hms(depth)) %>%
  drop_na()
view(CondData_time)

