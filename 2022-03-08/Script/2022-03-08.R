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
###
Europe <- rworldmap("Europe")
spain<- map_data("spain")

### Plotting 
EU <- erasmus %>% ## renaming data set for filtering 
  filter(academic_year == "2019-2020") %>%  ## filtering specific academic year 
  filter(participant_age >= 10,  participant_age <=25) %>% ## filter participant age from 10 to 25
  filter(sending_country_code == "UK") %>% # filter contry code UK 
  filter(sending_organization =="AFRICAN CENTRE FOR DEVELOPMENT AND RESEARCH LTD" |
         sending_organization =="Boys' and Girls' Clubs of Wales" | ## filter for sending organization 
           sending_organization == "WONDER FOUNDATION") %>% 
  select(academic_year, participant_nationality, participant_gender, participant_profile, participant_age, sending_city, receiving_city, sending_country_code, sending_organization) %>% 
  drop_na() ## selecting columns and dropping any NAs

 
EU %>% ## plotting data set 
ggplot() +
  geom_jitter(aes(x= receiving_city, y= participant_age, # creating a jitter plot of receiving city by participant age with points filtered by gender 
                 color = participant_gender)) +
  labs(x= "Recieving Cities", y= "Participant Age", ## creating labels 
       title = "Organizations in the UK",
       color = "Gender") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90), ## adjusting axis labels 
       plot.title = element_text(hjust = 0.25)) 

ggsave(here("2022-03-08", "Output", "OrganizationsintheUK.png")) ## saving image to output folder 




#country <- esp_get_country()
#lines <- esp_get_can_box()





###ggplot(country)+
 ## geom_sf()+
##  geom_point(data = EU, aes())


