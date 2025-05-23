# working out inputs and outputs
# library(tidyverse)
# library(distributional)
library(ggplot2)
# library(sf)

toydata <- toymap |>
  dplyr::filter(county_name %in% c("Dallas County", "Polk County", "Story County", "Boone County"))

# data with matching names for checking compute_group functions
named <- toydata |>
  dplyr::rename(fill = temp_dist) |>
  dplyr::select(county_name, geometry, fill)

# three data sets
a <- toydata |> dplyr::select(geometry, temp)
b <- toydata |> dplyr::select(geometry, temp_dist)
c <- b |>
  dplyr::mutate(temp_mean = distributional:::mean.distribution(temp_dist)) |>
  dplyr::select(geometry, temp_mean)


ggplot(b) + 
  geom_sf_sample(aes(geometry=geometry, fill=temp_dist)) 

ggplot(a) + 
  geom_sf(aes(geometry=geometry, fill=temp)) 



# actual examples
# normal map
toymap |> 
  ggplot() + 
  geom_sf(aes(geometry = geometry, fill=temp)) +
  scale_fill_viridis_c()

# sample map
toymap |> 
  ggplot() + 
  geom_sf_sample(aes(geometry = geometry, fill=temp_dist), linewidth=0.1, n=5) + 
  geom_sf(aes(geometry=geometry), fill=NA, linewidth=1) +
  scale_fill_viridis_c()




