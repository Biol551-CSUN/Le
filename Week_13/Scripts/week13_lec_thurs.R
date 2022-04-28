#### Today we are learning about models ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-28 ####


#### Load library ####
library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance)
library(modelsummary)
library(tidymodels)


#### basic linear model
#mod <- lm(y~x, data, = df)

#y is a function of x
#lm = linear model
#y = dependent variable
#x = independent variable(s)
#df = dataframe

#multiple regression
#mod <- lm(y~x1 + x2, data = df)

#interaction term
#mod<-lm(y~x1*x2, data = df)
#"*" will compute x1+x2+x1:x2


Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)
check_model(Peng_mod)
