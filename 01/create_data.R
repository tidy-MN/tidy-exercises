library(tidyverse)
library(palmerpenguins)

data(package = 'palmerpenguins')

df <- penguins


usual <- penguins[1:200, ]

new <- penguins[201:344,]

# Drop units
new <- new %>%
       rename_all(str_remove, "_mm|") %>%
       rename(penguin_species = species)

# Reorder
new <- new %>%
       relocate(island, .after = year)

# Year format
new$year <- as.character(new$year)

bind_rows(usual, new)

# SAVE
write_csv(new, "01/new_file.csv")
write_csv(usual, "01/the_correct_format.csv")
