### This is script for Week 3.
### Created by: Vivian Vy Le
### Created on: 2022-02-08
###############################

#### load libraries ####
library(palmerpenguins)
library(tidyverse)

#### data analysis ####
glimpse(penguins)

ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
                     shape = species,
                     size = body_mass_g,
                     alpha = flipper_length_mm)) +
  geom_point()+
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)",
       # color = "Species", #added a hash so that there is one legend, matches with top code
       caption = "Source: Palmer Pengiuns LTER/ palmerpenguin package") +
  scale_color_viridis_d() #changing the color of the graph, color blind friendly


#### data mapping vs setting ####
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
                     shape = species,
                     size = body_mass_g,
                     alpha = flipper_length_mm)) +
  geom_point(size = 2, alpha =0.5)+
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)",
       # color = "Species", #added a hash so that there is one legend, matches with top code
       caption = "Source: Palmer Pengiuns LTER/ palmerpenguin package") +
  scale_color_viridis_d() #changing the color of the graph, color blind friendly

#### testing out facets ####
ggplot(penguins,
       aes(x = bill_depth_mm,
           y = bill_length_mm))+
  geom_point()+
  facet_grid(species~sex)

ggplot(penguins,
       aes(x = bill_depth_mm,
           y = bill_length_mm))+
  geom_point()+
  facet_wrap(~ species)

ggplot(penguins,
       aes(x = bill_depth_mm,
           y = bill_length_mm))+
  geom_point()+
  facet_wrap(~ species, ncol = 2) #number of columns
