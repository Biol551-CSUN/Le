#### Today we are learning about functions and how to create them ####
#### Created by: Vivian Vy Le ####
#### Updated: 2022-03-17

#### load libraries ####
library(tidyverse)
library(palmerpenguins)
library(palettetown)
library(PNWColors)

#### creating a dataframe of random numbers ####
df <- tibble::tibble(a = rnorm(10), 
                    b = rnorm(10),
                    c = rnorm(10),
                    d = rnorm(10))
head(df)

df <- df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)))

df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
        # b = (b-min(b, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(b, na.rm = TRUE)),
        b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))


#can write a function for this
rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value)
}
df %>%
  mutate(a = rescale01(a),
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))

#### three things needed to create a new function ####
# pick a name for the function
# list the inputs or arguments to the function inside the funtion
# place the developed in body of the function, a { block that immediately follows function ()
# it is easier to create a function when you already wrote the code rather than creating the function from scratch

### making a new function
temp_c <-(temp_F - 32) * 5/9

f_to_c <- function(temp_F){
  temp_c <-(temp_F - 32) * 5/9
  return(temp_c)}

f_to_c(32)


#### think pair share ####
temp_K <-(tempc + 273.15)

c_to_k <- function(tempc){
  temp_K <-(tempc + 273.15)
  return(temp_K)}

c_to_k(2)


#### making plots into a function ####
pal <- "Pikachu" %>% ichooseyou(6)

ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_color_manual("Island", values = pal) +
  theme_bw()

myplot <- function(data, x, y){
  pal <- "Pikachu" %>% ichooseyou(6)
  ggplot(penguins, aes(x= x, y=y, color = island)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_color_manual("Island", values = pal) +
  theme_bw()}

myplot<-function(data, x, y){ 
  pal <- "Pikachu" %>% ichooseyou(6)
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+  
    theme_bw()
}

myplot(data = penguins, x = body_mass_g, y = bill_length_mm)
myplot(data = penguins, x = body_mass_g, y = flipper_length_mm)


#### adding defaults ####
myplot<-function(data = penguins, x, y){
  pal <- "Pikachu" %>% ichooseyou(6)
ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+  
  theme_bw()}

myplot(x = body_mass_g, y = flipper_length_mm)


#### layering the plot ####
myplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")


#### add an if-else statement for more flexibility ####
a <- 4
b <- 5
if (a > b) { # my question
  f <- 20 # if it is true give me answer 1
} else { # else give me answer 2
  f <- 10
}
f

#### plotting with if-else ####
myplot<-function(data = penguins, x, y ,lines=TRUE ){
  pal <- "Pikachu" %>% ichooseyou(6)
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+  
    theme_bw()}

myplot<-function(data = penguins, x, y, lines=TRUE){
  pal <- "Pikachu" %>% ichooseyou(6)
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()}
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()}}

myplot(x = body_mass_g, y = flipper_length_mm) #with lines
myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE) #without lines
