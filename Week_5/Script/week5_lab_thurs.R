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

### view data ###
view(Depthdata)
view(CondData)

### data analysis ###
CondData_time <- CondData %>%
  mutate(datetime = mdy_hms(depth), #dates started with month, day, year
         datetime = round_date(datetime, "10 seconds")) #rounding the time to the nearest 10 second
view(CondData_time)

Depthdata_time <-Depthdata %>%
  mutate(datetime = ymd_hms(date), #the dates for this column started with year not month like in CondData
         datetime = round_date(datetime, "10 seconds")) #rounding the time to the nearest 10 second
view(Depthdata_time)

CondandDepth <-inner_join(CondData_time,Depthdata_time, by = "datetime") %>%
  mutate(hours = hour(datetime),
         minutes = minute(datetime)) %>% #separating time by hours and minutes
  select(datetime, TempInSitu, SalinityInSitu_1pCal, Depth, hours, minutes) %>% #selecting to keep certain columns
  group_by(hours, minutes) %>% #grouping the dataset by hours and minutes
  unite(col = "Hours_Minutes", #uniting the hour and minute columns
        c(hours,minutes),
        sep = ".") %>% #removed the separate hour and minute columns
  relocate("Hours_Minutes", .after = "datetime") %>% #moved the column to after datetime, but after viewing and saving the csv file, column was moved to after datetime -__-
  group_by(Hours_Minutes) %>%
  summarise_at(c("datetime","TempInSitu", "SalinityInSitu_1pCal", "Depth"), mean) %>% #calculated the means for the selected columns
  write.csv(here("Week_5","Output","CondandDepth_summary.csv"))
view(CondandDepth) #AN: once saved the csv, remember to run the script and view before the save statement so that the object has values, can plot with values

#### plotting data ####
CondandDepth %>% #AN: need to run the script before the save state to have values in this object
  ggplot(aes(x = TempInSitu, y = SalinityInSitu_1pCal, color = Depth)) + #colorcoded by the depth of each measurement
  geom_point() + #added the datapoints to the graph
  geom_smooth() + #smooth graph this time, method is default to loess
  labs(title = "Salinity and Depth Trends over Temperature of Groundwater",
       x = "Temperature (°C)",
       y = "Salinity",
       fill = "Depth") + #changes the legend title
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = (element_text(hjust =0.5)),
        axis.text = element_text(size = 10),
        panel.border = element_rect(fill = NA, color = "black")) #added a border to the plot

ggsave(here("Week_5","Output","Salinity_Groundwater.png"), width = 6, height = 5)
  
