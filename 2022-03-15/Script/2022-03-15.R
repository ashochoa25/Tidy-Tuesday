### This is my Tidy Tuesday for 2022/03/15 on R Vignettes 
### Created by Ashlee Ochoa 
### Created on 2022/03/15

### Loading Libraries
library(tidyverse)
library(here)
library(ggplot2)
library(dplyr)
library(lubridate)

### Loading Data 
tuesdata <- tidytuesdayR::tt_load('2022-03-15')
tuesdata <- tidytuesdayR::tt_load(2022, week = 11)

bioc <- tuesdata$bioc

# Or read in the data manually

bioc <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-15/bioc.csv')
cran <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-15/cran.csv')

### Wrangling Data 

cran1 <- cran %>% 
  filter(version >= "1.0", version <= "2.0") %>% ### filtering version number from 1.0 to 2.9 

cran2<- cran1 %>% 
  filter(package == "zoo" | package == "accuracy" | package == "ade4" | package == "agricolae" | package == "gganimate" | package == "gitter") %>% 
mutate(date = ymd_hms(date,truncated = 1)) %>% ## filtering selected packages and mutating date into ymd_hms
  drop_na() # dropping NA

Data <- full_join(cran2, bioc) ## joiing data set together 

### Plotting Data
cran2 %>% ##3 plotting cran2
  ggplot(aes(x= package, y= date, ## package per date 
             color = version)) + ## color is package version 1.0- 2.0 
  geom_col()+ ## column graph 
  guides(color = FALSE) + ## removing legend 
  labs(x= "Package Name", y= "Increasing Time", ## addition of labels 
       title = "Color Correlation with Version Update")+
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) #centering data 

ggsave(here("2022-03-15", "Output", "Packageversions.png")) 
