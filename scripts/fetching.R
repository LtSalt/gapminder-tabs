################################################################################
# Fetching
################################################################################


# Dependencies ------------------------------------------------------------

if (!"pacman" %in% installed.packages()) install.packages("pacman")
pacman::p_load(tidyverse, googlesheets4, here)


# Urls --------------------------------------------------------------------

url_life_exp <- "https://docs.google.com/spreadsheets/d/1RheSon1-q4vFc3AGyupVPH6ptEByE-VtnjOCselU0PE/edit#gid=176703676"
url_gdp <- "https://docs.google.com/spreadsheets/d/17p7CPobPSyWb5dmVyf_bmZg9Jbh4PjlRPc0G1tJjTUk/edit#gid=176703676"
url_population <- "https://docs.google.com/spreadsheets/d/1c1luQNdpH90tNbMIeU7jD__59wQ0bdIGRFpbMm8ZBTk/edit#gid=501532268"
url_geography <- "https://docs.google.com/spreadsheets/d/1qHalit8sXC0R8oVXibc2wa2gY7bkwGzOybEMTWp-08o/edit#gid=1597424158"


# Read --------------------------------------------------------------------

life_exp <- read_sheet(life_exp, sheet = 4)
gdp <- read_sheet(url_gdp, sheet = 4)
population <- read_sheet(url_population, sheet = 4)
geography <- read_sheet(url_geography, 2)


# Save --------------------------------------------------------------------

exports <- list(life_exp, gdp, population, geography)
export_names <- c("life_exp", "gdp", "population", "geography")

walk2(exports, export_names, 
     ~ write_excel_csv(.x, here("data", paste0(.y, ".csv"))))

