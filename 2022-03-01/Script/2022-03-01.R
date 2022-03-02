### This is my Tidy-Tuesday for 2022-03-01 on alternative fuel stations 
### Created by Ashlee Ochoa
### Created on 2022-03-01


### Loading libraries
library(tidyverse)
library(tidytuesdayR)
library(ggplot2)
library(here)
library(dplyr)
library(usmap)

### Loading in Data 
tuesdata <- tidytuesdayR::tt_load('2022-03-01')
tuesdata <- tidytuesdayR::tt_load(2022, week = 9)

stations <- tuesdata$stations

# Or read in the data manually

stations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-01/stations.csv')

### Plotting 

data <- stations %>% 
  select(X, Y, FUEL_TYPE_CODE, STREET_ADDRESS, STATE, EV_PRICING, EV_ON_SITE_RENEWABLE_SOURCE, ACCESS_CODE) %>% ### selecting variables 
  mutate(X, Y, FUEL_TYPE_CODE, STREET_ADDRESS, STATE, EV_PRICING, EV_ON_SITE_RENEWABLE_SOURCE, ACCESS_CODE) %>% ### creating new columns 
  filter(FUEL_TYPE_CODE == "ELEC" | FUEL_TYPE_CODE == "LPG" | FUEL_TYPE_CODE == "E85") %>% ## filtering fuel type 
  filter(STATE == "CA" | STATE == "TX" | STATE == "MO"| STATE == "UT" | STATE == "NY" | STATE == "LA") %>% ## filtering for these specifics 
  drop_na() ## dropping data containing NA 
data %>% 
  ggplot(aes(x= STATE, y= EV_ON_SITE_RENEWABLE_SOURCE, ### plotting selected variables 
       group = FUEL_TYPE_CODE))+ 
  geom_hex() + ## graph type 
  labs(x= "State", y= "Renewable Source", ### labeling 
       title = "Electric Fuel Source Per State",
       fill= "Count")+ ## Cap on "count" 
  theme(plot.title = element_text(hjust = 0.5)) ## centering title 

ggsave(here("2022-03-01", "Output", "ElectricFuel_TT.png"))

 
  #geom_usmap
