#### Today we are going to plot penguin data with dlpyr ####
#### created by: Vivian Vy Le ####
#### updated on 2022-02-15 ####

####################################

#### load libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggthemes)

#### view data ####
glimpse(penguins)
view(penguins)

#### data analysis with dlpyr part 1 ####
#need to calculate the mean and variance of body mass by species, island, and sex without any NAs

penguin_summary<-penguins %>%
  drop_na(species, island, sex) %>% #drops the na data
  group_by(species, island, sex) %>% #creates new columns by these groups
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE), #calculates ave of body mass here
            varaiance = var(body_mass_g, na.rm = TRUE)) #calculates variance for body mass here

view(penguin_summary)

#### data analysis with dlpyr part 2 ####
#filter out male penguins, calculate log body mass, select columns for species, island, sex, and log body mass
#make any type of plot
#save the plot in output
penguin_plot<-penguins %>%
  drop_na(sex,island,body_mass_g) %>%
  filter(sex != "male") %>%
  mutate(log_body_mass = log(body_mass_g)) %>%
  select(species, island, sex, log_body_mass)
ggplot(data = penguin_plot, #penguin plot is the new dataset because we calculated for log body mass
       mapping = aes(x = species,
                     y = log_body_mass)) +
  geom_boxplot(aes(fill = species)) + #boxplots, and remember to add fill function
  scale_fill_manual(values= beyonce_palette(41)) + #remember to load the beyonce library
  labs(title = "Comapring Body Mass Across Female Penguin Species",
       x = "Species" , 
       y = "Log Body Mass (g)", #calculated the body mass in log
       caption = "Source: Palmer Pengiuns LTER/palmerpenguin package",
       fill = "Species") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size = 10),
        panel.border = element_rect(fill = NA, color = "black")) #adds a border to graph
ggsave(here("Week_4", "Output","penguin.plot.png"), width = 7, height = 6)

