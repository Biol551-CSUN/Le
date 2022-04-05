library(tidyverse)

mpg %>%
  ggplot(aes(x = displ, y = hwy))%>% 
  geom_point(aes(color = class))

# go to addins -> render reprex


lat	long	star_no
33.548	-117.805	10
35.534	-121.083	1
39.503	-123.743	25
32.863	-117.24	22
33.46	-117.671	8

# to copy and paste the data properly
# addins -> under datapasta, pasta as tibble

data <- tibble::tribble(
    ~lat,    ~long, ~star_no,
  33.548, -117.805,      10L,
  35.534, -121.083,       1L,
  39.503, -123.743,      25L,
  32.863,  -117.24,      22L,
   33.46, -117.671,       8L
  )

data
