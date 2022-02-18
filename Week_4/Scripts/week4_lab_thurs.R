### Today we are going to plot chemical data for thurs lab ###
### Created by: Vivian Vy Le ###
### updated on: 2022-02-17 ###
#############################

#### load libraries ####
library(tidyverse)
library(here)
library(beyonce)

#### reading the data ####
Chemdata <-read.csv(here("Week_4","Data","chemicaldata_maunalua.csv"))
glimpse(Chemdata)
view(Chemdata)

#### data analysis ####
Chemdata_clean <- Chemdata %>%
  filter(complete.cases(.),
         Site == "BP") %>% #filtering to only look at data from site BP
  separate(col = Tide_time,
           into = c("Tide","Time"), #separating the columns into two new columns
           sep = "_") %>%
  pivot_longer(cols = Salinity:TA, #used columns from salinity to TA and pivot the table
               names_to = "Variables", #creates a new column called variables, which includes NN, pH, Phosphate, Salinity, Silicate, TA
               values_to = "Values") #creates a new column that has all values from each sample n=918
view(Chemdata_clean)

Chemdata_sum <- Chemdata_clean %>% #created a new object for a summary
  group_by(Variables, Season, Tide, Time) %>%
  summarize(Value_mean = mean(Values, na.rm = TRUE), #calculated the mean
            Value_sd = sd(Values, na.rm = TRUE), #calculated the stdev
            Value_var = var(Values, na.rm = TRUE)) %>% #calculated the variance
  write_csv(here("Week_4","Output","Chemdata_sum.csv"))
view(Chemdata_sum)

#### plotting chemdata as violin plots ####
Chemdata_clean %>%
  ggplot(aes(x = Season, y = Values, fill = Season)) +
  geom_violin() + #used a violin plot to see the trend of the data 
  geom_dotplot(binaxis = "y", #adding dots to show the raw data, overlays on the violin plot
               dotsize = 0.2, 
               stackdir = "center") + 
  facet_wrap(~Variables, scale = "free") +
  labs(title = "Comparing Submarine Groundwater Samples in Fall and Spring Seasons",
       subtitle = "Samples measured at BP site",
       caption = "Source: Data collected in Hawai'i by Silbiger Lab at CSUN") +
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = (element_text(hjust =0.5)),
        axis.text = element_text(size = 10),
        panel.border = element_rect(fill = NA, color = "black")) + #created a border around the graphs
  scale_fill_manual(values= beyonce_palette(11)) #borahae
ggsave(here("Week_4","Output","Groundwater_by_Season.png"), width = 7, height = 6)
