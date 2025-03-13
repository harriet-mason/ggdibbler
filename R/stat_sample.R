#' @export
StatSample <- ggplot2::ggproto("StatSample", ggplot2::StatSf,
                               # compute_layer is literally code from stat_sf
                               compute_panel = function(self, data, scales, coord, n = NULL) {
                                 if (is.null(n)) {n = 3}
                                 
                                 # subdivide and sample data
                                 data <- data |>
                                   dplyr::group_by(geometry) |>
                                   dplyr::reframe(
                                     geometry = subdivide(geometry, d=c(n,n)), 
                                     dplyr::across(dplyr::everything())
                                   ) |>
                                   dplyr::mutate(fill = as.double(distributional::generate(fill, 1))) |>
                                   sf::st_sf() |>
                                   sf::st_zm()
                                 
                                 ggproto_parent(StatSf, self)$compute_panel(data, scales, coord)
                               },
                               required_aes = c("geometry")
)

#' @export
# internal function for subdividing geometry grid
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