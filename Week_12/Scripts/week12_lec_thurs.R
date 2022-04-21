#### Today we are learning how to work with factors ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-21 ####

#### load libraries ####
library(tidyverse)
library(here)

#### load data ####
income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')

#### view data ####
glimpse(starwars)
view(starwars)
glimpse(income_mean)

#### data analysis: starwars ####
star_counts <- starwars %>%
  filter(!is.na(species)) %>%
  mutate(species = fct_lump(species, n = 3)) %>%
  count(species)
view(star_counts)

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) %>%
  droplevels() %>% #drops extra levels
  mutate(species = fct_recode(species, "Humanoid" = "Human"))
view(starwars_clean)

levels(starwars_clean$species)

#### plotting data ###
p1 <- star_counts %>%
  ggplot(aes(x = fct_reorder(species, n), y = n)) +
  geom_col()


p2 <- star_counts %>%
  ggplot(aes(x = fct_reorder(species, n, .desc =  TRUE), y = n)) +
  geom_col() +
  labs(x = "Species")


### data analysis: income mean ####
total_income <-income_mean %>%
  group_by(year, income_quintile) %>%
  summarise(income_dollars_sum = sum(income_dollars)) %>%
  mutate(income_quintile = factor(income_quintile))
view(total_income)            


### plot ####
p3 <- total_income %>%
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile, year, income_dollars_sum))) +
  geom_line() +
  labs(color = "Income Quantile")

#### reorder levels ####
x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))
x1
