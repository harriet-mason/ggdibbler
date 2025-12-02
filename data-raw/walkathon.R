library(dplyr)
library(googlesheets4)
library(tidyr)
library(usethis)

# read in raw data
# convert comments in cells to NA
gsheet <- "https://docs.google.com/spreadsheets/d/1JnbfbEF27gyywQCmuqN66OR2p2d2M1JZv3xxJr5N4xs/"
walktober <- read_sheet(gsheet, range = "A4:AG29", 
                        col_types = paste0("cc", strrep("i", 31)))

# remove example row
walktober <- walktober |>  
    slice(-1)

# pivot longer (keep or remove NAs)
walktober <- walktober |>
    pivot_longer(`01/10/25`:`31/10/25`,
                 names_to = "date",
                 values_to = "steps") |>
    rename(team = `Team Name`, name = `Name`)

# create data/walktober.rda
use_data(walktober, overwrite = TRUE)


