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
         se = runif(99, min=0, max=3)) 

# make distribution tibble
# toymap <- toymap |> 
#  mutate(temp_dist = dist_normal(temp, se),
#         temp_sample = generate(temp_dist, 50)) |> 
#  select(county_name, geometry, temp, temp_dist, temp_sample)

# Geometry Info
toy_geometry <- toymap |> 
  dplyr::select(county_name, geometry) |>
  dplyr::group_by(geometry)
  
  
# "Raw" data
toymap_raw <- toymap |> 
  dplyr::group_by(geometry) |>
  dplyr::reframe(
    temp = unlist(generate(dist_normal(temp, se), 10)), 
    dplyr::across(dplyr::everything())
  ) |>
  mutate(id = row_number()) |>
  dplyr::select(id, county_name, temp)

# Mean data
toymap_mean <- toymap_raw |> 
  dplyr::group_by(county_name) |>
  summarise(temp_avg = mean(temp))
  
# Mean and variance data
toymap_est <- toymap_raw |> 
  dplyr::group_by(county_name) |>
  summarise(temp_mean = mean(temp),
            temp_std = sd(temp))

# Sample
toymap_sample <- toymap_raw |> 
  dplyr::group_by(county_name) |>
  dplyr::summarise(temp_psample = dist_sample(list(temp))) |>
  dplyr::select(county_name, temp_psample) 

# Distribution
toymap_dist <- toymap_est |> 
  mutate(temp_dist = dist_normal(temp_mean, temp_std)) |>
  select(county_name, temp_dist) 






#toymap_raw

# make into dibble object
# ??? idk

# use toymap data in package.
usethis::use_data(toymap, overwrite = TRUE)







