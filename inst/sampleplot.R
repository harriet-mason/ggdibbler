# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()

toydata <- toymap |>
  dplyr::filter(county_name %in% c("Story County", "Boone County", "Johnson County"))

# data with matching names for checking compute_group functions
named <- toydata |>
  dplyr::rename(fill = temp_dist) |>
  dplyr::select(geometry, fill)

# three data sets
a <- toydata |> dplyr::select(geometry, temp)
b <- toydata |> dplyr::select(geometry, temp_dist)
c <- b |>
  dplyr::mutate(temp_mean = distributional:::mean.distribution(temp_dist)) |>
  dplyr::select(geometry, temp_mean)

# Location based StatSample
StatSample <- ggplot2::ggproto("StatSample", ggplot2::Stat,
                               compute_group = function(data, scales, n) {
                                 data |>
                                   dplyr::mutate(y = distributional::generate(y, n)) |>
                                   tidyr::unnest(y)
                                 
                               },
                               required_aes = c("y")
)

stat_sample <- function(mapping = NULL, data = NULL, 
                        geom = "point", position = "identity", 
                        na.rm = FALSE, show.legend = NA, 
                        inherit.aes = TRUE, n=10, ...) {
  ggplot2::layer(
    stat = StatSample, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm,
                  n = n, ...)
  )
}

# test plot
ggplot2::ggplot() +
  stat_sample(data = b, 
              ggplot2::aes(x=county_name, y=temp_dist), n=30,
              size=0.5)