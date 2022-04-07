### The REAL Group 5
### Sophia Boyd, Brandon Bonilla, Alex Dang, Vivian Vy Le

library(tidyverse)
library(palmerpenguins)

penguin %>%
  ggplot(aes(x= bill_depth_mm,
             y = bill_length_mm,
             color = islands)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "Comparing Penguins Length and Depth",
       x = "Depth (mm)",
       y = "Length (mm)")


#Group 2's response to Group 5
#penguin should be penguins, islands should be island
library(tidyverse)
library(palmerpenguins)

penguins %>%
  ggplot(aes(x= bill_depth_mm,
             y = bill_length_mm,
             color = island)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "Comparing Penguins Length and Depth",
       x = "Depth (mm)",
       y = "Length (mm)")