### Today we are learning how to lubridate data ###
### Created by: Vivian Vy Le ###
### Updated: 2022-02-24 ###

#### load libraries ####
library(tidyverse)
library(here)
library(lubridate) #package for dealing with date and time
library(beyonce)

### load data ###
Depthdata <- read_csv(here("Week_5", "Data","DepthData.csv"))
CondData <- read_csv(here("Week_5","Data","CondData.csv"))

### view data ###
view(Depthdata)
view(CondData)

### data analysis ###
CondData_time <- CondData %>%
  mutate(datetime = mdy_hms(depth),
         datetime = round_date(datetime, "10 seconds")) %>%
  drop_na()
view(CondData_time)

Depthdata_time <-Depthdata %>%
  mutate(datetime = ymd_hms(date),
         datetime = round_date(datetime, "10 seconds"))
view(Depthdata_time)

CondandDepth <- inner_join(CondData_time,Depthdata_time) %>%
  mutate(hours = hour(datetime),
         minutes = minute(datetime)) %>%
  select(datetime, TempInSitu, SalinityInSitu_1pCal, Depth, hours, minutes) %>%
  group_by(minutes) %>%
  summarize(mean_Temp = mean(TempInSitu, na.rm = TRUE),
            mean_Salinity = mean(SalinityInSitu_1pCal, na.rm = TRUE),
            mean_depth = mean(Depth, na.rm = TRUE))
view(CondandDepth)

#### plotting the data ###
CondandDepth %>%
  ggplot(aes(x = minutes, y = mean_Temp)) +
  geom_boxplot()
           
