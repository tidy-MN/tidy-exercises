
# Pull in packages
library(tidyverse)

# Read in new data
new_format <- read_csv("https://raw.githubusercontent.com/tidy-MN/weekly-exercise/main/01/new_file.csv")

# Read in correctly formatted data
correct_format <- read_csv("https://raw.githubusercontent.com/tidy-MN/weekly-exercise/main/01/correct_format.csv")

names(new_format)
names(correct_format)

# Rename and reorganize new file
corrected_file <- new_format %>%
  rename(species = penguin_species) %>%
  select(species, island, everything(), year)

# Check work
glimpse(corrected_file)
glimpse(correct_format)

# Save file
write_csv(corrected_file, "C:/Users/kellickson/OneDrive - Union of Concerned Scientists/R/Tidy Tuesday/weekly_exercise_result.csv")
