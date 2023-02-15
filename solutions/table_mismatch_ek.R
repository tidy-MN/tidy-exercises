library(tidyverse)


new_file <- read_csv("weekly-exercise/01/new_file.csv")
correct_format <- read_csv("weekly-exercise/01/correct_format.csv")

colnames(new_file)
colnames(correct_format)

new_file <- rename(new_file, 
                   species = penguin_species)

new_file <- new_file[, c(1, 8, 2, 3, 4, 5, 6, 7)]

colnames(new_file)
colnames(correct_format)
