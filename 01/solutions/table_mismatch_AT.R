install.packages("tidyverse")


#put libraries here
library(dplyr)
library(readr)
library(ggplot2)
library(tidyverse)


#data_set

correct <- read.csv("01/correct_format.csv")
new <- read.csv("01/new_file.csv")

glimpse(correct)
glimpse(new)


count(correct)
count(new)

correct %>% count(species) 
correct %>% count(island) 
new %>% count(island) 

correct_stats <- group_by(correct, species) %>%
   summarise(mean = mean(bill_length_mm, na.rm = T))


new_stats <- group_by(new, penguin_species) %>%
  summarise(mean = mean(bill_length_mm, na.rm = T))    

new_columns <- rename(new,species = penguin_species)

all_data <- full_join(correct,new_columns)

ggplot(all_data, aes(x=body_mass_g, y= bill_length_mm, color = species)) +
  geom_point()

ggplot(all_data, aes(x=island, y= species)) +
  geom_bar()

ggplot(all_data, aes(x=body_mass_g, y= bill_length_mm)) +
  geom_point() + 
  facet_wrap(island)

