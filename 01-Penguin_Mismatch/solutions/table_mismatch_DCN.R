library(tidyverse)
library(data.table)

correct_file_path <- "01/correct_format.csv"
new_file_path <- "01/new_file.csv"
output_path <- "01/new_file_formatted_DN.csv"

correct <- read_csv(correct_file_path)
new_file <- read_csv(new_file_path)
new_file <- rename(new_file, species = penguin_species)
new_file <- select(new_file, !!names(correct))
fwrite(new_file, output_path)
