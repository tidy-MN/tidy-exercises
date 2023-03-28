library(tidyverse)
library(janitor)

new <- read_csv( "01/new_file.csv")
correct <- read_csv("01/correct_format.csv")

names(new)
names(correct)

# Column names match? janitor::
compare_df_cols(new, correct)

new <- new %>% select(island, everything()) 

names(new)
names(correct)

# Update names
names(new) <- names(correct) 

all <- bind_rows(correct, new)

# Test again
compare_df_cols(all, correct)

compare_df_cols(all, select(correct, -year))


# Save file
write_csv(all, "Updated_csv.csv")


