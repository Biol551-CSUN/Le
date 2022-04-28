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
library(palettetown)


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

penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(color = "Species",
       x = "Bill Length (mm)",
       y = "Bill Depth (mm)")+
  theme_bw()

  

Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)

##checking model performance 
check_model(Peng_mod)

#anova
anova(Peng_mod)

#Coefficients (effect size) with error
summary(Peng_mod)

#view results with broom
# Tidy coefficients
coeffs<-tidy(Peng_mod)
coeffs

# tidy r2, etc
results<-glance(Peng_mod) 
results

# tidy residuals, etc
resid_fitted<-augment(Peng_mod)
resid_fitted

#model summary functions
Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)

models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)

modelsummary(models, output = here("Week_13","Output","table.docx"))


modelplot(models) +
  labs(x = 'Coefficients', 
       y = 'Term names') +
  scale_color_manual(values = pokepal(6))

#models with purr, dpylr, broom
models<- penguins %>%
  ungroup() %>%
  nest(data = -species) %>%
  mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .)))
models
models$fit


results<-models %>%
  mutate(coeffs = map(fit, tidy), # look at the coefficients
         modelresults = map(fit, glance))  # R2 and others
results


results<-models %>%
  mutate(coeffs = map(fit, tidy), # look at the coefficients
         modelresults = map(fit, glance)) %>% # R2 and others 
  select(species, coeffs, modelresults) %>% # only keep the results
  unnest() # put it back in a dataframe and specify which columns to unnest
view(results) # view the results


#tidymodels
linear_reg()

lm_mod<-linear_reg() %>%
  set_engine("lm") %>%
  fit(bill_length_mm ~ bill_depth_mm*species, data = penguins) %>%
  tidy() %>%
  ggplot()+
  geom_point(aes(x = term, y = estimate))+
  geom_errorbar(aes(x = term, ymin = estimate-std.error,
                    ymax = estimate+std.error), width = 0.1 )+
  coord_flip()

lm_mod
