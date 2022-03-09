### Today we are learning a map ###
### Created by: Vivian Vy Le ###
### Updated: 2022-03-08 ###

#### Load libraries ####
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)

#### load data ####
#read population in California by county
popdata<-read_csv(here("Week_7", "Data","CApopdata.csv")) 

#read in data on number of seastars at different field sites
stars<-read_csv(here("Week_7","Data","stars.csv")) 

world<-map_data("world") #get the data for the world

usa<-map_data("usa") #get the data for the usa

states<-map_data("state") #get the data for the states

counties<-map_data("county") #get the data for county

#### view data ####
view(popdata)
view(stars)
glimpse(usa)
glimpse(world)
glimpse(states)
glimpse(counties)

#### plotting world map ####
ggplot() +
  geom_polygon(data = world,
               aes(x = long, y = lat, 
                   group = group, #remember to add group = group so that it does not wraps the map
                   fill = region),
               color = "black") +
  theme_minimal() +
  guides(fill = FALSE) +
  theme(panel.background = element_rect((fill = "lightblue"))) +
  coord_map(projection = "mercator", #Mercator is the projection focusing on the Atlantic Ocean
            xlim = c(-180,180))


#### plotting California and counties in California ####
CA_data <- states %>%
  filter(region == "california")

CApop_county <-popdata %>%
  select("subregion" = County, Population) %>%
  inner_join(counties) %>% #joins the data sets by subregion
  filter(region == "california")
view(CApop_county)

#think pair share#
ggplot() +
  geom_polygon(data = CA_data,
               aes(x = long, y = lat, group = group), 
               fill = "darkgray", #fill outside of aes fills in the shape with the color
               color = "black") + #border of the shape is black
  coord_map() +
  labs(x = "Longitude",
       y = "Latitude") +
  theme_minimal()

ggplot() +
  geom_polygon(data = CApop_county,
               aes(x = long, y = lat, group = group,
                   fill = Population),
               color = "black") +
  geom_point(data = stars,
             aes(x = long, y = lat, size = star_no)) +
  labs(size = "Star per Meter Square",
       x = "Longitude",
       y = "Latitude",
       fill = "Population",
       title = "The Relationship between Sea Stars and the Population of California") +
  coord_map() +
  theme_minimal() + 
  scale_fill_viridis_c(trans = "log10")
ggsave(here("Week_7", "Output", "Sea_Star_CA.png"), width = 6, height = 5)
