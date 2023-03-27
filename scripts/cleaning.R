################################################################################
# Cleaning
################################################################################


# Dependencies ------------------------------------------------------------

if(!"pacman" %in% installed.packages()) install.packages("pacman")
pacman::p_load(tidyverse, here, janitor, jsonlite)


# Import ------------------------------------------------------------------

file_paths <- list.files(here("data"), full.names = TRUE)
gapminder_tibbles <- map(file_paths, ~ read_csv(.x))


# Merge -------------------------------------------------------------------

geography_selection <- gapminder_tibbles[[2]] %>% 
  select(name, four_regions, Latitude, Longitude)

gapminder_merge <- gapminder_tibbles[c(1, 3, 4)] %>% 
  map(~select(.x, -geo)) %>% 
  reduce(full_join, by = c("name", "time")) %>% 
  full_join(geography_selection, by = "name")


# Sanity Checks -----------------------------------------------------------

gapminder_merge %>% 
  filter(is.na(four_regions))

gapminder_merge %>% 
  group_by(name, time) %>% 
  count(name) %>% 
  filter(n() > 1)


# Clean -------------------------------------------------------------------

gapminder_merge_cleaned <- gapminder_merge %>% 
  select(-c(`GDP total`, `GDP per capita growth (%)`)) %>% 
  clean_names()
  

# Export ------------------------------------------------------------------

# write_json(gapminder_merge_cleaned, here("app", ))
