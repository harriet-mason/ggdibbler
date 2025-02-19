
# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()

toydata <- toymap |>
  dplyr::filter(county_name %in% c("Story County", "Boone County", "Johnson County"))


# data with matching names for checking compute_group functions
named <- toydata |>
  dplyr::rename(x = county_name, fill = temp_dist) |>
  dplyr::select(x, fill)

# three data sets
a <- toydata |> dplyr::select(county_name, temp)
b <- toydata |> dplyr::select(county_name, temp_dist)
c <- b |>
  dplyr::mutate(temp_mean = distributional:::mean.distribution(temp_dist)) |>
  dplyr::select(county_name, temp_mean)

# Fill based StatMeanVar (cant check without propper ggplot)
StatMeanVar <- ggplot2::ggproto("StatMeanVar", ggplot2::Stat, 
                                compute_group = function(data, scales) {
                                  data$hue <- distributional:::mean.distribution(data$fill)
                                  data$saturation <- distributional:::variance.distribution(data$fill)
                                  data
                                },
                                required_aes = c("fill")
)
# tested compute_group function and it works. Cant check the rest until fill is done

# Dont have a geom that takes two values for the fill function

GeomSfDist <- ggproto("GeomSfDist", ggplot2::GeomSf,
                      # Specify the required aesthetics                   
                      required_aes = c("geometry", "hue", "saturation"),
            
)
)
# need function that generates the plot




# Ideal code
#ggplot(toydata) +
#  geom_sf(aes(geometry, fill=temp_dist)) +
#  scale_fill_VSUP()
