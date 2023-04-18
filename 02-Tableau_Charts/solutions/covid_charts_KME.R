# Pull in packages
library(tidyverse)
#remotes::install_github("MPCA-data/mncolors")
library(mncolors)
library(tigris)
library(sf)
library(ggthemes)
library(janitor)
library(scales)

# Remaining problems: reverse color palette in mn_colors, labelling y or x axis with a character percent.

# Read in data for chart 1
vax <- read_csv('https://raw.githubusercontent.com/tidy-MN/tidy-exercises/main/02-Tableau_Charts/01_vax_trends.csv') %>%
  clean_names()

vax_long <- pivot_longer(vax, cols = -c(week_start_date, age_group, web_date), names_to = "vax_category", values_to = "vax_categories_percents") %>%
  clean_names() %>%
  filter(!is.na(week_start_date)) %>%
  group_by(week_start_date, age_group, web_date, vax_category) %>%
  summarise(vax_categories_percents = mean(vax_categories_percents, na.rm = T)) %>%
  ungroup() %>%
  mutate(week_start_date = ymd(week_start_date)) %>%
  mutate(vax_labels = paste(vax_categories_percents, "%"))

ggplot(data = vax_long, aes(x = week_start_date, y = vax_categories_percents, group = vax_category, fill = vax_category)) +
  geom_area() +
  scale_x_date(breaks = "3 month", labels = date_format("%b %Y")) +
  #scale_x_discrete(breaks = unique(vax_long$vax_categories_percents), labels = vax_long$vax_labels) +
  scale_y_continuous(breaks = 0:100, labels = "vax_labels", limits = c(0, 100)) +
  xlab(NULL) +
  ylab(NULL) +
  scale_fill_mn(palette = "primary", reverse = TRUE) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(caption = "Bar chart showing people with at least one vaccine dose, complete vaccine series, and up to date on vaccines over age group.",
       title = "People Vaccinated Over Time") +
  theme(legend.position="bottom", legend.box = "horizontal", legend.title = element_blank())


# Chart # 2

vax2 <- read_csv('https://raw.githubusercontent.com/tidy-MN/tidy-exercises/main/02-Tableau_Charts/02_agegroup_vax_rates.csv') %>%
  mutate(value = round(value, digits = 2),
         value_label = paste(value * 100, "%"))

ggplot(data = vax2, aes(x = agegroup, y = value, fill = vaccine_status)) +
  geom_col(aes(x = agegroup, y = round(value, digits = 2), group = vaccine_status, label = value_label), position = "dodge") +
  geom_text(aes(x = agegroup, y = round(value, digits = 2), group = vaccine_status, label = value_label), position = position_dodge(width = .9), size = 3, hjust = -0.1) +
  coord_flip() +
    #scale_x_continuous(labels = as.factor(`Month Year`)) +
  xlab(NULL) +
  ylab(NULL) +
  scale_fill_mn(palette = "primary", reverse = TRUE) +
  labs(caption = "Bar chart showing people with at least one vaccine dose, complete vaccine series, and up to date on vaccines by age group or gender.") +
  theme(legend.position="bottom", legend.box = "horizontal", legend.title = element_blank())


# Chart 3
vax3 <- read_csv('https://raw.githubusercontent.com/tidy-MN/tidy-exercises/main/02-Tableau_Charts/03_county_vax_rates.csv') %>%
  mutate(GEOID = as.character(GEOID))

counties <- counties(state = "MN")

vax3 <- left_join(vax3, counties, by = c("GEOID" = "GEOID", "COUNTYFIPS" = "COUNTYFP"))

vax3_long <- pivot_longer(vax3, cols = c("People with at least one vaccine dose", "People with completed vaccine series", "People up to date with vaccine doses"), names_to = "vax_category", values_to = "vax_categories_percents") %>%
  filter(vax_category == "People up to date with vaccine doses")

vax3_long <- st_as_sf(vax3_long, sf_column_name = "geometry")

ggplot(vax3_long) +
  geom_sf(aes(fill = vax_categories_percents)) +
  xlab(NULL) +
  ylab(NULL) +
  ggthemes::theme_map() +
  scale_color_mn(palette = "primary", reverse = TRUE, direction = -1) +
  guides(color = guide_legend(reverse = TRUE)) +
  labs(caption = "Statewide for at least one vaccine dose. Map of up to date vaccine rates for Minnesotans by county.",
       title = "Up to date vaccinations by county") +
  theme(legend.position="bottom", legend.box = "horizontal", legend.title = element_blank())
