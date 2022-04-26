#### Today we are learning about iterative coding ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-26 ####

#### load libraries ####
library(tidyverse)
library(here)


#### simple for loop ####
print(paste("The year is", 2000))

years<- c(2015:2021)

for(i in years){ #set up the for loop where is is the index
  print(paste("The year is", i)) #loop over i
}

#this does not save a vector in the environment
#to save a new vector, need to pre-allocate space and tell R where it is going to be saved

#empty matrix
year_data <- data.frame(matrix(ncol = 2, nrow = length(years)))

#add column names
colnames(year_data) <- c("year", "year_name")
year_data

for(i in 1:length(years)){
  year_data$year_name[i] <- paste("The year is", years[i])
}
#do not forget to add the bracket on both sides
#this will change for each row instead of writing the same thing over and over
year_data


for(i in 1:length(years)){
  year_data$year_name[i] <- paste("The year is", years[i])
  year_data$year[i]<-years[i]
}
year_data

testdata<-read_csv(here("Week_13", "Data", "cond_data", "011521_CT316_1pcal.csv"))
view(testdata)

CondPath <- here("Week_13", "Data", "cond_data")
files <- dir(path = CondPath, pattern = ".csv")
files

cond_data<-data.frame(matrix(nrow = length(files), ncol = 3))
colnames(cond_data)<-c("filename","mean_temp", "mean_sal")
cond_data

raw_data<-read_csv(paste0(CondPath,"/",files[1]))
head(raw_data)


for (i in 1:length(files)){
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  cond_data$filename[i]<-files[i]
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
}



#### map
#there are 3 ways to do this
#Use a canned function that already exists
1:10 %>%
  map(rnorm, n = 15) %>%
  map_dbl(mean)


## same thing but different notation
#make your own function
1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)

##Use a formula when you want to change the arguments within the function
1:10 %>%
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function
  map_dbl(mean)


### bringing the files using purr
files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE)
files

data<-files %>%
  set_names()%>% 
  map_df(read_csv,.id = "filename") %>%
  group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data

