### This is my Tidy Tuesday for 2022-03-09 on EU student Mobility 
### Created by Ashlee Ochoa 
### Created on 2022-03-09

### Loading Libraries 
library(tidyverse)
library(ggplot2)
library(here)
library(dplyr)
library(usmap)
library(rworldmap)
library(mapproj)
library(mapdata)
library(mapSpain)


### Loading Data 
tuesdata <- tidytuesdayR::tt_load('2022-03-08')
tuesdata <- tidytuesdayR::tt_load(2022, week = 10)

erasmus <- tuesdata$erasmus

# Or read in the data manually

erasmus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-08/erasmus.csv')

Europe <- rworldmap("Europe")
spain<- map_data("spain")

### Plotting 
EU <- erasmus %>% 
  filter(academic_year == "2019-2020") %>% 
  filter(participant_age >= 10,  participant_age <=25) %>% 
  filter(sending_country_code == "UK") %>% 
  filter(sending_organization =="AFRICAN CENTRE FOR DEVELOPMENT AND RESEARCH LTD" |
         sending_organization =="Boys' and Girls' Clubs of Wales" |
           sending_organization == "WONDER FOUNDATION") %>% 
  select(academic_year, participant_nationality, participant_gender, participant_profile, participant_age, sending_city, receiving_city, sending_country_code, sending_organization) %>% 
  drop_na()

 
EU %>% 
ggplot() +
  geom_jitter(aes(x= receiving_city, y= participant_age,
                 color = participant_gender)) +
  labs(x= "Recieving Cities", y= "Participant Age", 
       title = "Organizations in the UK",
       color = "Gender") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90),
       plot.title = element_text(hjust = 0.25))





#country <- esp_get_country()
#lines <- esp_get_can_box()





###ggplot(country)+
 ## geom_sf()+
##  geom_point(data = EU, aes())


