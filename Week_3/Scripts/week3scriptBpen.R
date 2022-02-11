### Today we are going to plot penguin data ###
### Created by: Vivian Vy Le ###
### updated on: 2022-02-10 ###

### load libraries ###
library(tidyverse)
library(palmerpenguins)
library(here)
library(beyonce)

### load data ###
glimpse(penguins)
head(penguins)
tail(penguins)
view(penguins)

plot1<-ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") + #this creates a best fit line for the data
  labs(title = "Bill depth and length", x = "Bill depth (mm)", y = "Bill length (mm)") +
  scale_color_manual(values = beyonce_palette(27)) + #borahae
  theme_bw() +
  theme(axis.title = element_text(size = 20,
                                  color = "black"),
        panel.background = element_rect(fill = "linen"))
ggsave(here("Week_3","output","penguin.png"), width = 7, height = 6)
