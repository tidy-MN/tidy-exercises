# https://github.com/tidy-MN/weekly-exercise/tree/main/01
# Create a new project and Clone this repository by clicking the green <> Code button and copying the HTTPS link
# 
# Or skip that and download the two CSV files at https://github.com/tidy-MN/weekly-exercise/01.
# Create a new R script named table_mismatch_YOUR_INITIALS.R
# 
# Change the column names in new_file.csv to match the column names in correct_format.csv.
# 
# Save the updated file to a CSV named 01_new_file_formatted.csv
# 
# Save your script to the solutions/ folder
# 
# If you cloned the repository, use the Git tab in RStudio to Commit and Push your saved R script back to GitHub


library(tidylog)
library(tidyverse)
library(skimr)
library(janitor)

#read in the files
new <- read_csv("01/new_file.csv")

correct <- read_csv("01/correct_format.csv")


#coerce the new file in to the correct format 

skim(correct)
skim(new)

names(new)
names(correct)

#double check whether penguin species, island, sex from new and the correct species match 
unique(new$penguin_species)
unique(correct$species)
unique(new$island)
unique(correct$island)
unique(new$sex)
unique(correct$sex)

#compare ranges of numeric values but ignore the NAs 
#Ranges generally match eachother, i.e., are in the same units, same kind of measurements
range(new$bill_depth_mm, na.rm =  TRUE)
range(correct$bill_depth_mm, na.rm = TRUE)
range(new$bill_length_mm, na.rm =  TRUE)
range(correct$bill_length_mm, na.rm = TRUE)
range(new$body_mass_g, na.rm = TRUE)
range(correct$body_mass_g, na.rm = TRUE)

#check years, esp for format
unique(new$year)
unique(correct$year)


#Based on looking at the the data,
#it seems reasonable to combine these by just restructuring the order of the "new" table to rbind them together
# island to island - spelling and caps match
# penguin_species to species 
# bill_length_mm as bill_length_mm
# flipper_length_mm to flipper_length_mm
# body_mass_g to body_mass_g
# sex to sex - genders match, both do include "NA" as a category
# year to year

new <- new %>% rename(species = penguin_species) %>%
                                select(species, island, bill_length_mm, bill_depth_mm, flipper_length_mm,
                                body_mass_g, sex, year) 
#I couldn't get this to rbind within the rename and arrange, so I kept it out as its own line
more_penguins <- rbind(new, correct)

#double check the output to make sure nothing weird happened
skim(more_penguins)

write_csv(more_penguins, "01_new_file_formatted.csv")
