### This is my first script. I am learning how to import data.
### Created by:
### Created on: 2022-02-03
#############################################

### load libraries #####
library(tidyverse)
library(here)

##### Read in data #####
weightdata<-read_csv(here("Week_2","data","weightdata.csv"))

### Data Analysis ####
head(weightdata) # looks at top 6 lines
tail(weightdata) # looks at bottom 6 lines
view(weightdata) # view the dataset
