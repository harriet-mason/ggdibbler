# Packages for toy data set
library(distributional)
library(tidyverse)
# devtools::install_github("UrbanInstitute/urbnmapr")
library(urbnmapr)
library(rgeos)
library(sf)

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
    location = st_sample(geometry, 10), 
    dplyr::across(dplyr::everything())
  ) |>
  mutate(temp = unlist(generate(dist_normal(temp, se), 1)),
         id = row_number()) |>
  sf::st_sf() |>
  dplyr::select(id, county_name, geometry, location, temp)


# Plot Raw Data
ggplot(toymap_raw) +
  geom_sf(aes(geometry=geometry)) + 
  geom_sf(aes(geometry=location, colour=temp))
  
# Mean data
toymap_mean <- toymap_raw |> 
  dplyr::group_by(county_name) |>
  summarise(temp_avg = mean(temp))
  
# Plot Mean Data

# Mean and variance data
toymap_est <- toymap_raw |> 
  dplyr::group_by(county_name) |>
  summarise(temp_mean = mean(temp),
            temp_std = sd(temp))

# Distribution
toymap_dist <- toymap_est |> 
  mutate(temp_dist = dist_normal(temp_mean, temp_std)) |>
  select(county_name, temp_dist) 

# Plot Distribution Data

# Sample
# BOOTSTRAP
# MAKE DIST WITH SAMPLE





#toymap_raw

# make into dibble object
# ??? idk

# use toymap data in package.
usethis::use_data(toymap, overwrite = TRUE)


nc = st_read(system.file("shape/nc.shp", package="sf"))

p1 = st_sample(nc[1:3, ], 6)


