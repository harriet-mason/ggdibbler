# Packages for toy data set
library(distributional)
library(tidyverse)
# devtools::install_github("UrbanInstitute/urbnmapr")
library(urbnmapr)
library(rgeos)

# Generate Data
my_map_data <- get_urbn_map("counties", sf = TRUE) |>
  filter(state_name=="Iowa") 

# Re-save so I dont have to keep calling it
toymap <- my_map_data

# this section uses rgeos to make sine wave pattern
centroids <- as_tibble(gCentroid(as(toymap$geometry, "Spatial"), byid = TRUE))
toymap$cent_long <- centroids$x
toymap$cent_lat <- centroids$y

#make trend and variance
toymap <- toymap |>
  mutate(temp = as.double(round(29 - 2*abs(scale(cent_lat) - sin(2*(scale(cent_long)))), digits=1)), # trend
         se = runif(99, min=0, max=3), # high variance
         count_id = row_number()) 

# make distribution tibble
# toymap <- toymap |> 
#  mutate(temp_dist = dist_normal(temp, se),
#         temp_sample = generate(temp_dist, 50)) |> 
#  select(county_name, geometry, temp, temp_dist, temp_sample)


# "Raw" data
toymap_raw <- toymap |> 
  dplyr::reframe(
    temp_obs = generate(dist_normal(temp, se), 10), 
    dplyr::across(dplyr::everything())
  ) |>
  mutate(longitude = cent_long + runif,
         )

# Mean
toymap_mean <- toymap |> 
  select(county_name, geometry, temp)
    
# Sample
toymap_sample <- toymap |> 
  select(county_name, geometry, temp_sample) |> 
  rename(temp = temp_sample)

# Distribution
toymap_dist <- toymap |> 
  select(county_name, geometry, temp_dist) |>
  rename(temp = temp_dist)


#toymap_raw

# make into dibble object
# ??? idk

# use toymap data in package.
usethis::use_data(toymap, overwrite = TRUE)







