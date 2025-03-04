# working out inputs and outputs
#library(tidyverse)
#library(distributional)
devtools::load_all()
library(ggplot2)

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
                                 data |>
                                   dplyr::group_by(geometry) |>
                                   dplyr::reframe(geometry = subdivide(geometry, d=c(n,n)), 
                                                  dplyr::across(dplyr::everything())) |>
                                   dplyr::mutate(fill = as.double(distributional::generate(fill, 1))) |>
                                   sf::st_sf() |>
                                   sf::st_zm()
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


# make stat function

stat_sample <- function(mapping = aes(), data = NULL, geom = "rect",
                           position = "identity", na.rm = FALSE, show.legend = NA,
                           inherit.aes = TRUE, ...) {
  layer_sf(
      geom = geom,
      data = data,
      mapping = mapping,
      stat = StatSample,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = rlang::list2(
        na.rm = na.rm,
        ...
        )
  )
}

ggplot(data=b) +
  geom_sf(aes(geometry = after_stat(geometry), fill = after_stat(fill)),
        stat = "stat_sample")

# make layer function

geom_sf_sample <- function(mapping = aes(), data = NULL,
                    position = "identity", na.rm = FALSE, show.legend = NA,
                    inherit.aes = TRUE, ...) {
  c(
    layer_sf(
      geom = GeomSf,
      data = data,
      mapping = mapping,
      stat = StatSample,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = rlang::list2(
        na.rm = na.rm,
        ...
      )
    ),
    coord_sf(default = TRUE)
  )
}


# doesn't work
#ggdebug::ggdebug(ggplot, GeomSf$draw_panel)
#ggdebug::ggundebug(ggplot, GeomSf$draw_panel)


ggplot(b) + 
  geom_sf_sample(aes(geometry=geometry, fill=temp_dist)) 

ggplot(a) + 
  stat_sf(aes(geometry=geometry, fill=temp)) +
  coord_sf()

ggplot(a) + 
  geom_sf(aes(geometry=geometry, fill=temp))




ggplot(b) + 
  stat_sample(aes(geometry=geometry))




# check what format the data that is fed into geom_polygon should be
named <- toydata |>
  dplyr::rename(x = temp, y = se) |>
  dplyr::select(x, y) |>
  sf::st_drop_geometry()

named[chull(named$x, named$y), , drop = FALSE]







