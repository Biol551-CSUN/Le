### Today we are going to practice joins with data from Becker and Silbiger (2020) ####
### Created by: Vivian Vy Le ####
### Updated on 2022-2-22 ####
#######################

#### load libraries ####
library(tidyverse)
library(here)

### load data ###
#Environmental data from each site
EnviroData<-read_csv(here("Week_5", "Data","site.characteristics.data.csv"))

#thermal performance data
TPCData<-read_csv(here("Week_5","Data","Topt_data.csv"))
glimpse(EnviroData)
glimpse(TPCData)
view(EnviroData)
view(TPCData)

#### data analysis ####
EnviroData_wide<- EnviroData %>% #pivoting the dataset so that it is a wide datasest to match the Topt data
  pivot_wider(names_from = parameter.measured,
              values_from = values)
view(EnviroData_wide)

#another way to summarize the data by values without pivoting the table
#FullData_left <-left_join(TPCData, EnviroData_wide) %>% #joins the two datasheets by site.letter
  #relocate(where(is.numeric),.after = where(is.character)) %>% #this groups the categories together
  #summarise_if(is.numeric, list(mean = mean, var = var), na.rm = TRUE) #calculates the values and each column will have one value
#view(FullData_left) 

FullData_left <- left_join(TPCData, EnviroData_wide)
view(FullData_left)

FullData_long <- FullData_left %>%
  pivot_longer(cols = E:substrate.cover,
               names_to = "Variables",
               values_to = "Values") %>%
  group_by(site.letter) %>% #prof wanted the data by site
  summarise(Val_means = mean(Values, na.rm = TRUE),
            Val_vars = var(Values, na.rm = TRUE))
view(FullData_long)

#### learning how to create a tibble ####
#make 1 tibble
T1 <- tibble(Site.ID = c("A", "B","C","D"),
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T2 <-tibble(Site.ID = c("A", "B","C","D"),
            pH = c(7.3, 7.8, 8.1, 7.9))
right_join(T1,T2) #joins to T2
left_join(T1,T2) #joins to T1
inner_join(T1,T2) #only keeps the data that is complete in both data sets
full_join(T1,T2) #keeps everything
semi_join(T1,T2) #keeps all rows form the first data set where there are matching values in the second data set
anti_join(T1,T2) #helpful in finding unique values


#### practice with joins ####
T3 <- tibble(Site.ID = c("A","B","C","D"),
             Temperature = c(12,15,19.2,20.4))
T4 <- tibble(Site.ID=c("A","B","C","D","E"),
             pH = c(7.8,7.9,7.6,6.0,8)) 
right_join(T3,T4) #keeps the fifth row from T4
left_join(T3,T4) #does not keep the fifth row from T4
right_join(T4,T3) #does not keep the fifth row from T4
left_join(T4,T3) #keeps the fifth row from T4
inner_join(T3,T4)
inner_join(T4,T3)
full_join(T3,T4)
semi_join(T3,T4) #keeps temperature column
semi_join(T4,T3) #keeps pH column
anti_join(T3,T4) #message: tibble 0x2 with 2 variables
