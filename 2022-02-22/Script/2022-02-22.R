### This is my first Tidy-Tuesday for the 2021 Spring Semester. Displaying the trend in Political rights over a decade in France, Peru, and The United States of America. 
### Created by Ashlee Ochoa 
### Created on 2022-02-22

### Inserting Library 
library(tidyverse)
library(tidytuesdayR)
library(ggplot2)
library(here)
library(freedom)
library(dplyr)


### Inserting Data
tuesdata <- tidytuesdayR::tt_load('2022-02-22')
tuesdata <- tidytuesdayR::tt_load(2022, week = 8)
tt_data <- tt_load("2022-02-22")

freedom <- tuesdata$freedom

freedom <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-22/freedom.csv')

read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-22/freedom.csv')
 
    
### Plotting
data<- freedom %>% 
  select(country, year, PR, CL) %>% ### selecting Variables from data frame 
  filter(country == "Peru" | country == "United States of America" | country == "France") %>% ### "|" used instead of & for the time frame selected 
  filter(year >2009) ### years after (greater than 2009) 2010-2020

view(data) 

data1 <- data %>% 
  ggplot(aes(x= as_factor(year), y= PR, ## as_factor for year used so no decimal point follows 
             group= country, # grouping by country 
             color= country))+ ## color by country 
  geom_line()+ ## line graph 
  labs(x = "Year", y= "Political Rights", title = "Political Rights", subtitle = "Overtime in France, Peru, & The US") +
  #theme(element_text(l))
  scale_color_manual(values = c("purple", "orange", "red"))+
  theme_classic()


data1 ## name of data frame to see the visual of the dataset 

ggsave(here("2022-02-22", "Output", "PR_TT.png"))
  


