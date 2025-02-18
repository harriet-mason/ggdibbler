
# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()

toydata <- toymap |>
  dplyr::filter(county_name == "Story County" | 
                  county_name == "Boone County" | 
                  county_name == "Johnson County")

# data with matching names for checking compute_group functions
named <- toydata |>
  dplyr::rename(x = county_name, y = temp_dist) |>
  dplyr::select(x, y)

# three data sets
a <- toydata |> dplyr::select(county_name, temp)
b <- toydata |> dplyr::select(county_name, temp_dist)
c <- b |>
  dplyr::mutate(temp_mean = distributional:::mean.distribution(temp_dist)) |>
  dplyr::select(county_name, temp_mean)

# Fill based StatMeanVar (cant check without propper ggplot)
StatMeanVar <- ggplot2::ggproto("StatMeanVar", ggplot2::Stat, 
                                compute_group = function(data, scales) {
                                  data$mfill <- distributional:::mean.distribution(data$fill)
                                  data$vfill <- distributional:::variance.distribution(data$fill)
                                  data
                                },
                                required_aes = c("fill")
)
# tested compute_group function and it works. Cant check the rest until fill is done

# 


# Ideal code
geom_sf()