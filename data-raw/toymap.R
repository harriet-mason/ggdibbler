# Packages for toy data set
library(distributional)
library(tidyverse)
# devtools::install_github("UrbanInstitute/urbnmapr")
library(urbnmapr)
library(rgeos)
library(sf)

set.seed(1)

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
         se = runif(99, min=1, max=7)) 

# make distribution tibble
# toymap <- toymap |> 
#  mutate(temp_dist = dist_normal(temp, se),
#         temp_sample = generate(temp_dist, 50)) |> 
#  select(county_name, geometry, temp, temp_dist, temp_sample)
  
# "Raw" data
toy_temp <- toymap |> 
  dplyr::group_by(county_name) |>
  dplyr::reframe(
    #location = st_sample(geometry, 20), 
    temp = unlist(generate(dist_normal(temp, se), 20)),
    dplyr::across(dplyr::everything())
  ) |>
  slice_sample(prop = 0.5) |>
  rename(county_geometry = geometry,
         county_longitude = cent_long,
         county_latitude = cent_lat,
         recorded_temp = temp) |>
  dplyr::select(county_name, county_geometry, county_longitude, county_latitude, recorded_temp)
toy_temp$readerID <- paste("#", sample(seq(10000, 99999), length(toy_temp$recorded_temp)), sep="")

# Plot Raw Data
ggplot(toy_temp) +
  geom_sf(aes(geometry=county_geometry)) +
  geom_jitter(aes(x=county_longitude, y=county_latitude, colour=recorded_temp), 
              width=5000, height =5000) 
  
# Mean data
toy_temp_mean <- toy_temp |> 
  st_drop_geometry() |>
  dplyr::group_by(county_name) |>
  summarise(temp_mean = mean(temp)) |>
  left_join(iowa_counties)|>
  sf::st_sf()
  
# Plot Mean Data
ggplot(toy_temp_mean) +
  geom_sf(aes(geometry=geometry, fill=temp_mean)) 


# Mean and variance data
toy_temp_est <- toy_temp |> 
  st_drop_geometry() |>
  dplyr::group_by(county_name) |>
  summarise(temp_mean = mean(temp),
            temp_se = sd(temp)/sqrt(n())) |>
  left_join(iowa_counties)|>
  sf::st_sf()

# ??? Cant really plot this

# Distribution
toy_temp_dist <- toy_temp_est |> 
  mutate(temp_dist = dist_normal(temp_mean, temp_se)) |>
  select(county_name, temp_dist, geometry) 

# Plot Distribution Data
ggplot(toy_temp_dist) +
  ggdibbler::geom_sf_sample(aes(geometry=geometry, fill=temp_dist)) 


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


