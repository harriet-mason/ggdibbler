# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()

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

# Function that splits geometry up into subdivided sections
subdivide <- function(geometry, d){
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

# Location based StatSample
StatSample <- ggplot2::ggproto("StatSample", ggplot2::StatSf,
                               # compute_layer is literally code from stat_sf
                               compute_group = function(data, scales, coord, n = NULL) {
                                 if (is.null(n)) {n = 10}
                                 # subdivide and sample data
                                 data <- data |>
                                   dplyr::group_by(geometry) |>
                                   dplyr::reframe(geometry = subdivide(geometry, d=c(n,n)), 
                                                  dplyr::across(dplyr::everything())) |>
                                   dplyr::mutate(fill = as.double(distributional::generate(fill, 1)))
                                 sf::st_sf(data)
                               },
                               
                               required_aes = c("geometry")
)


test <- StatSample$compute_group(named, n=20)

# check geometry alone works
ggplot(test) + 
  geom_sf(aes(geometry=geometry)) 

# check geometry and fill
ggplot(test) + 
  geom_sf(aes(geometry=geometry, fill=fill)) +
  scale_fill_viridis_c()


# make layer function

stat_sample <- function(mapping = NULL, data = NULL,
                    position = "identity", na.rm = FALSE, show.legend = NA,
                    inherit.aes = TRUE, ...) {
  layer_sf(
    stat = StatSample,
    data = data,
    mapping = mapping,
    geom = GeomSf,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}
# doesn't work
#ggdebug(ggplot, GeomSf$draw_panel)
#ggundebug(ggplot, GeomSf$draw_panel)

ggplot(b) + 
  stat_sample(aes(geometry=geometry))




# check what format the data that is fed into geom_polygon should be
named <- toydata |>
  dplyr::rename(x = temp, y = se) |>
  dplyr::select(x, y) |>
  sf::st_drop_geometry()

named[chull(named$x, named$y), , drop = FALSE]







