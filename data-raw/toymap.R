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
         se = runif(99, min=1, max=4)) 

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
  dplyr::select(county_name, county_geometry, county_longitude, county_latitude, recorded_temp) |>
  st_sf()
toy_temp$scientistID <- paste("#", sample(seq(10000, 99999), length(toy_temp$recorded_temp)), sep="")

# Plot Raw Data
ggplot(toy_temp) +
  geom_sf(aes(geometry=county_geometry)) +
  geom_jitter(aes(x=county_longitude, y=county_latitude, colour=recorded_temp), 
              width=5000, height =5000) +
  scale_colour_viridis_c()
  
# Mean data
toy_temp_mean <- toy_temp |> 
  dplyr::group_by(county_name) |>
  summarise(temp_mean = mean(recorded_temp)) 
  
# Plot Mean Data
ggplot(toy_temp_mean) +
  geom_sf(aes(geometry=county_geometry, fill=temp_mean)) +
  scale_fill_viridis_c()


# Mean and variance data
toy_temp_est <- toy_temp |> 
  dplyr::group_by(county_name) |>
  summarise(temp_mean = mean(recorded_temp),
            temp_se = sd(recorded_temp)/sqrt(n())) 

# ??? Cant really plot this

# Distribution
toy_temp_dist <- toy_temp_est |> 
  mutate(temp_dist = dist_normal(temp_mean, temp_se)) |>
  select(county_name, temp_dist) 

# Plot Distribution Data
ggplot(toy_temp_dist) +
  geom_sf_sample(aes(geometry=county_geometry, fill=temp_dist)) +
  scale_fill_viridis_c()

# Better plot of distribution data
ggplot(toy_temp_dist) + 
  geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist), linewidth=0.1) + 
  geom_sf(aes(geometry = county_geometry), fill=NA, linewidth=1) +
  scale_fill_viridis_c()

# Sample
# BOOTSTRAP
# MAKE DIST WITH SAMPLE


# use toymap data in package.
usethis::use_data(toy_temp, overwrite = TRUE)
usethis::use_data(toy_temp_dist, overwrite = TRUE)

