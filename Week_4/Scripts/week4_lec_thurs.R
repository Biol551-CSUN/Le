### Today we are going to plot chemical data ###
### Created by: Vivian Vy Le ###
### updated on: 2022-02-17 ###
#############################

#### load libraries ####
library(tidyverse)
library(here)

#### reading the data ####
Chemdata <-read.csv(here("Week_4","Data","chemicaldata_maunalua.csv"))
glimpse(Chemdata)
view(Chemdata)

Chemdata_clean<-Chemdata %>%
  filter(complete.cases(.)) %>% #this also removes any NAs
  separate(col = Tide_time, #column want to separate
           into = c("Tide", "Time"), #columns want to create from the column wanted to separate
           sep = "_", #separate by _
           remove = FALSE) %>% #this function is used to keep the original column because separating the column will delete the original column
  unite(col = "Site_Zone", #this will be the name of the new column
        c(Site,Zone), #these names are not in quotes because these columns already exist
        sep = ".", #putting a . in the middle
        remove = FALSE)
view(Chemdata_clean)

#### using pivot long ####

Chemdata_long <-Chemdata_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, #pivoting the columns with values
               names_to = "Variables", #the names of the new cols with all the column names
               values_to = "Values") #names of the new column with all the values
view(Chemdata_long)

Chemdata_sum <-Chemdata_long %>% #created a new object for summary
  group_by(Variables, Site) %>%
  summarise(Param_means = mean(Values, na.rm = TRUE), #calculates mean
            Param_vars = var(Values, na.rm = TRUE)) #calculates variance
view(Chemdata_sum)

#### first think pair share ####
Chemdata_sumv2<-Chemdata_long %>%
  group_by(Variables, Site, Zone, Tide) %>%
  summarise(Param_means = mean(Values, na.rm = TRUE), 
            Param_vars = var(Values, na.rm = TRUE), #calculates variance
            Param_sd = sd(Values, na.rm = TRUE)) #calculates stdev, note that "sd" is the same used in dplyr
view(Chemdata_sumv2)

#### plotting the pivot long data ####
Chemdata_long %>%
  ggplot(aes(x = Site, y = Values)) +
  geom_boxplot() +
  facet_wrap(~Variables, scales = "free") #the y axis is not scaled to be the same for all of the categories and graphs

#### using pivot wide ####
Chemdata_wide <-Chemdata_long %>%
  pivot_wider(names_from = Variables,
              values_from = Values)
view(Chemdata_wide)

#### learning how to export the csv file ####
Chemdata_clean <-Chemdata %>%
  filter(complete.cases(.)) %>%
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>%
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>% #write in a pipe before exporting it as a csv file
  write_csv(here("Week_4","Output","summary.csv"))
