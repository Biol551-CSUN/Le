### Today we are learning different packages for plotting ###
### Created by: Vivian Vy Le ###
### Updated: 2022-03-15  ###

#### load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(palmerpenguins)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)

#### view libraries ####
glimpse(penguins)

#### plotting data ####
### learning how to use patchwork
p1<-penguins %>%
  ggplot(aes(x = body_mass_g,
             y = bill_length_mm,
             color = species)) +
  geom_point()

p2<- penguins %>%
  ggplot(aes(x = sex,
             y = body_mass_g,
             color = species)) +
  geom_jitter(width = 0.2)

p1+p2 +
  plot_layout(guides = 'collect') +
  plot_annotation(tag_levels = "A")

### put one plot on top of the other
p1/p2 +
  plot_layout(guides = "collect") +
  plot_annotation(tag_levels = "A")


### learning about ggrepel ###
view(mtcars)

ggplot(mtcars, aes (x=wt,
                    y = mpg,
                    label = rownames(mtcars))) +
  geom_label_repel() +
  geom_point(color = "red")

### learning about gganimate ####
penguins %>%
  ggplot(aes(x = body_mass_g,
             y = bill_depth_mm,
             color = species)) +
  geom_point() +
  transition_states(
    year,
    transition_length = 2,
    state_length = 1) +
  ease_aes("bounce-in-out") +
  ggtitle('Year: {closest_state}')
anim_save(here("Week_8","output","mypengiungif.gif"))


### learning about magick ###
penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")
penguin

#need to save plot as an image first
penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point()
ggsave(here("Week_8", "Output", "simpleplot.png"))

penplot <- image_read(here("Week_8", "Output", "simpleplot.png"))
out<- image_composite(penplot, penguin, offset = "-70+30")
out

#can do this with gifs too
pengif<-image_read("https://media3.giphy.com/media/H4uE6w9G1uK4M/giphy.gif")
outgif <- image_composite(penplot, pengif, gravity = "center")
animation <- image_animate(outgif, fps = 10, optimize = TRUE)
animation
