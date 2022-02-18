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
               names_to = "Variables",
               values_to = "Values")
view(Chemdata_clean)

Chemdata_sum <- Chemdata_clean %>% #created a new object for a summary
  group_by(Variables, Season, Tide, Time) %>%
  summarize(Value_data = mean(Values, na.rm = TRUE),
            Value_sd = sd(Values, na.rm = TRUE),
            Value_var = var(Values, na.rm = TRUE)) %>%
  write_csv(here("Week_4","Output","Chemdata_sum.csv"))
view(Chemdata_sum)

#### plotting chemdata as violin plots ####
Chemdata_clean %>%
  ggplot(aes(x = Season, y = Values, fill = Season)) +
  geom_violin() + #used a violin plot to see the trend of the data
  facet_wrap(~Variables, scale = "free") +
  labs(title = "Comparing Submarine Groundwater Samples in Fall and Spring Seasons",
       subtitle = "Samples measured at BP site") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size = 10),
        panel.border = element_rect(fill = NA, color = "black")) +
  scale_fill_manual(values= beyonce_palette(11)) #borahae
  

