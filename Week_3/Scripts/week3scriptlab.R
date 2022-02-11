### Today we are going to plot penguin data ###
### Created by: Vivian Vy Le ###
### updated on: 2022-02-10 ###
#############################

### load libraries ###
library(tidyverse)
library(palmerpenguins)
library(here)
library(beyonce)
library(ggthemes)

### load data ###
glimpse(penguins)
head(penguins)
tail(penguins)
view(penguins)

### creating the plot ###
ggplot(data=penguins,
       mapping = aes(x = species,
                     y = body_mass_g)) +
  geom_boxplot(aes(fill = species)) +
  geom_dotplot(binaxis = "y",
               dotsize = 0.2,
               stackdir = "center") +
  scale_fill_manual(values= beyonce_palette(39)) +
  labs(title = "Body Mass Across Penguin Species", x = "Species", y = "Body Mass (g)") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size = 10),
        panel.border = element_rect(fill = NA, color = "black"))
ggsave(here("Week_3","output","body_mass_pens.png"), width = 7, height = 6)
