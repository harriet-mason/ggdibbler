# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()

toydata <- toymap |>
  dplyr::filter(county_name %in% c("Dallas County", "Polk County", "Story County", "Boone County"))

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

subdivide <- function(geometry, d = c(3,3)){
  # make n*n grid
  g <- sf::st_make_grid(geometry, n=d)
  # combine grid and original geometry into sf
  a <- c(geometry, g)
  sf <- sf::st_sf(a)
  # get interactions of grid and orginal geometry
  i = sf::st_intersection(sf)
  # new subdivided geometry 
  subdivided <- i |> 
    dplyr::filter( `n.overlaps` >=2) |> #get grid elements that overlap with original shape
    dplyr::filter(sf::st_geometry_type(a) %in% c("POLYGON")) # get rid of other weird line stuff
  subdivided$a
}

plot(subdivide(toydata$geometry[1]))

# check what format the data that is fed into geom_polygon should be
named <- toydata |>
  dplyr::rename(x = temp, y = se) |>
  dplyr::select(x, y) |>
  sf::st_drop_geometry()

named[chull(named$x, named$y), , drop = FALSE]







