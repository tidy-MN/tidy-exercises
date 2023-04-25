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
  geom_area(position = "identity") +
  scale_x_date(breaks = "3 month", labels = date_format("%b %Y")) +
  scale_y_continuous(breaks = (0:5)*20, labels = function(x) paste0((0:5)*20, " %"), limits = c(0, 100)) +
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
  scale_y_continuous(labels = scales::percent) +
  coord_flip() +
  xlab(NULL) +
  ylab(NULL) +
  scale_fill_mn(palette = "primary", reverse = TRUE) +
  labs(caption = "Bar chart showing people with at least one vaccine dose, complete vaccine series, and up to date on vaccines by age group or gender.",
       title = "Proportion of people vaccinated by age") +
  theme(legend.position="bottom", legend.box = "horizontal", legend.title = element_blank())


# Chart 3
vax3 <- read_csv('https://raw.githubusercontent.com/tidy-MN/tidy-exercises/main/02-Tableau_Charts/03_county_vax_rates.csv')

counties <- counties(state = "MN") %>%
  mutate(across(GEOID, as.integer))

vax3 <- left_join(vax3, counties, by = c("GEOID" = "GEOID"))

vax3_long <- pivot_longer(vax3, cols = c("percent_with_at_least_one_dose", "percent_with_completed_vaccine_series", "percent_up_to_date_with_vaccine_doses"), names_to = "vax_category", values_to = "vax_categories_percents") %>%
  filter(vax_category == "percent_up_to_date_with_vaccine_doses")

vax3_long <- st_as_sf(vax3_long, sf_column_name = "geometry")
vax3_long$bins <- cut(round(vax3_long$vax_categories_percents, digits = 0), breaks = 4)

ggplot(vax3_long) +
  geom_sf(aes(fill = bins)) +
  xlab(NULL) +
  ylab(NULL) +
  ggthemes::theme_map() +
  scale_color_mn(palette = "primary", direction = -1) +
  scale_fill_manual("bins", 
                    labels = c("< 18%","18 - 26%", "26 - 33%", "> 33%"),
                    values = c("lightcyan", "light blue", "royalblue1", "dark blue")) +
  labs(caption = "Statewide for at least one vaccine dose. Map of up to date vaccine rates for Minnesotans by county.",
       title = "Up to date vaccinations by county") +
  theme(legend.position="bottom", legend.box = "horizontal", legend.title = element_blank())
