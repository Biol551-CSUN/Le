#### Today we are going to plot penguin data with dlpyr ####
#### created by: Vivian Vy Le ####
#### updated on 2022-02-15 ####

####################################

#### load libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)

#### view data ####
glimpse(penguins)
view(penguins)
head(penguins)

#### lecture portion on filter ####
filter(.data = penguins, # filtering out data
       sex == "female")
#one equal sign means it sets an argument in the function
#two equal signs means it reads as "exactly equal to" T/F


#### first think pair share ####
filter(.data = penguins,
       sex == "female", #characters should be in quotes
       year == 2008) #measured in year 2008, numbers can be in quotes or without quotes

filter(.data = penguins,
       sex == "female",
       body_mass_g > 5000) #greater than 5000 grams

#### second think pair share ####
filter(.data = penguins,
       year == 2008|2009) #penguin data collected in either 2008 or 2009

filter(.data = penguins,
       island != "Dream") #excluding penguins from Dream island

filter(.data = penguins, species == "Adelie"| species == "Gentoo") #filtering for penguins in Adelie or Gentoo

filter(.data = penguins, species %in% c("Adelie", "Gentoo")) #using %in% as to include same group


#### lecture portion on mutate ####
data2 <-mutate(.data = penguins,
                body_mass_kg = body_mass_g/1000, #converting the data from g to kg
               bill_length_depth = bill_length_mm/bill_depth_mm) #calculating the ratio of bill length and depth
view(data2)

data2<-mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008")) #help create another column for conditional tests
view(data2)
#case_when --> if there are two more options

#### third think pair share ####
data2<-mutate(.data = penguins,
               flipper_with_body_mass = flipper_length_mm + body_mass_g) #adding a column to add flipper length and body mass

view(data2)

data2<-mutate(.data = penguins,
              body_mass_over_4000 = ifelse(body_mass_g>4000, "big", "small")) #adding a conditional column where big is over 4000g and small is less than 4000g
view(data2)

#############
data3<-penguins %>% #using the penguins data without the .data function
  filter(sex == "female") %>% #selects for females 
  mutate(log_mass = log(body_mass_g)) %>% #calculates log of body mass
  select(Species = species, island, sex, log_mass) #capitalizes species column

data4<-penguins %>% # 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE)) #na.rm skips over the missing data

data4<-penguins %>% # 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm=TRUE)) #calculates the min flipper and adds a new column

data5<-penguins %>%
  group_by(island) %>% #groups by island
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE)) #then calculates the ave and max for each island, all are on seperate columns

data6<-penguins %>%
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))


#### removing NA from data ####
data6<-penguins %/%
  drop_na(sex) %>%
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

#### pipe into a ggplot ####
penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()
