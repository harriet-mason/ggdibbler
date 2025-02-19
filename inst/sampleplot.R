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
                               compute_group = function(data, scales, n = NULL) {
                                 if (is.null(n)) {n = 10}
                                 data |>
                                   dplyr::mutate(fill = distributional::generate(fill, n)) |>
                                   tidyr::unnest(fill)
                                 
                               },
                               required_aes = c("fill")
)

StatSample$compute_group(named)


# Function that splits geometry up into subdivided sections
geometry <- named[[ ggplot2:::geom_column(named) ]]
sf::st_bbox(geometry)

# check what format the data that is fed into geom_polygon should be
named <- toydata |>
  dplyr::rename(x = temp, y = se) |>
  dplyr::select(x, y) |>
  sf::st_drop_geometry()

named[chull(named$x, named$y), , drop = FALSE]

# try to make a grid of values from the geometry
# sf::st_make_grid(geometry) # this function should make a grid inside the geometry