# working out inputs and outputs
library(ggplot2)
library(tidyverse)
library(vctrs)
devtools::load_all()

# Basic DF in DF out approach
sample_df <- function(df){

}
n=10
m <- toymap |>
  select(c(county_name, temp_dist, geometry)) |>
  mutate(count=n) |>
  uncount(count) |>
  rowid_to_column("ID") |>
  group_by(ID, county_name, temp_dist, geometry) |>
  summarise(temp_sample = distributional::generate(temp_dist, 1)) |>
  #separate_longer_delim(temp_sample, delim = ",")
  # I mean it works

# have to use different versions of these functions for sf or tibble
# runs fine if i have tidyerse loaded, but cant call each package indirectly
