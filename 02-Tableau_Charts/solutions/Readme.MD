# Week 1 Summarized


## Load data
```r
library(readr)

new <- read_csv( "01/new_file.csv")
correct <- read_csv("01/correct_format.csv")
```

## View differences

### Base
```r
names(new)
names(correct)
```

### dplyr
```r
glimpse(new)
glimpse(correct)
```


### Janitor
```r
library(janitor)

compare_df_cols(new, correct)
```

### skimr
```r
library(skimr)

skim(correct)
skim(new)
```

### `unique()`
```r
unique(new$penguin_species)
unique(correct$species)
```

### `range()`
```r
range(new$bill_depth_mm, na.rm =  TRUE)
range(correct$bill_depth_mm, na.rm = TRUE)
```

### `summarize()` stats
```r
new %>% 
  group_by(penguin_species) %>%
  summarise(mean = mean(bill_length_mm, na.rm = T))

correct %>%
  group_by(species) %>%
  summarise(mean = mean(bill_length_mm, na.rm = T))
```


## Renaming

### With caution
```r
new <- new %>% rename(species = penguin_species)
```

### Caution to the wind
```r
# Have to rearrange columns first
new <- new %>% relocate(island, .after = species) 

names(new) <- names(correct) 
```


## Relocate columns

### `relocate()`
```r
library(dplyr)

new %>% relocate(island, .after = species) 
```

### `select()`
```r
new %>% 
  select(penguin_species, island, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, sex, year) 

# everything()       
new <- new %>% 
       select(penguin_species, island, everything())
       
# Derek's famous !! bang-bang
new <- select(new, !!names(correct))
```


## Join tables

### `bind_rows()`
```r
library(dplyr)

all_the_penguins <- bind_rows(correct, new)
```

### `full_join()`
```r
library(dplyr)

all_the_penguins <- full_join(correct, new)
```


## Re-test

Difference checking tools from above and plots.

### `ggplot`
```r
ggplot(all_the_penguins, 
       aes(x = body_mass_g, y= bill_length_mm, color = species)) +
  geom_point()

ggplot(all_the_penguins, aes(x=body_mass_g, y= bill_length_mm)) +
  geom_point() + 
  facet_wrap(~island)
  
ggplot(all_the_penguins, aes(x = island, fill = species)) +
  geom_bar()  
```


## Save

### readr
```r
write_csv(all_the_penguins, "01/new_file_corrected.csv")
```

### fwrite
```r
library(data.table)

out_path <- "01/new_file_formatted_DN.csv"

fwrite(all_the_penguins, out_path)
```

## Time race! (`tictoc`)

### fwrite vs read_csv

```r
library(tictoc)

out_path1 <- "01/solutions/new_file_formatted_fwrite.csv"
out_path2 <- "01/solutions/new_file_formatted_readr.csv"

# fwrite
tic()
fwrite(all_the_penguins, out_path1)
toc()

#---------#

# read_csv
tic()
write_csv(all_the_penguins, out_path2)
toc()
```

