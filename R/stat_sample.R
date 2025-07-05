#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto StatSf
#' @importFrom dplyr group_by reframe across everything mutate filter
#' @importFrom sf st_sf st_zm st_make_grid st_intersection st_geometry_type
#' @rdname geom_sf_sample
StatSample <- ggplot2::ggproto("StatSample", StatSf,
                               # compute_layer is literally code from stat_sf
                               compute_panel = function(self, data, scales, coord, n = NULL) {
                                 if (is.null(n)) {n = 3}
                                 
                                 # subdivide and sample data
                                 data <- data |>
                                   group_by(geometry) |>
                                   reframe(
                                     geometry = subdivide(geometry, d=c(n,n)), 
                                     across(everything())
                                   ) |>
                                   mutate(fill = as.double(distributional::generate(fill, 1))) |>
                                   st_sf() |>
                                   st_zm()
                                 
                                 ggproto_parent(StatSf, self)$compute_panel(data, scales, coord)
                               },
                               required_aes = c("geometry")
)

# internal function for subdividing geometry grid
subdivide <- function(geometry, d){
  n.overlaps <- NULL #to avoid binding error
  # make n*n grid
  g <- st_make_grid(geometry, n=d)
  # combine grid and original geometry into sf
  a <- c(geometry, g)
  sf <- st_sf(a)
  # get interactions of grid and orginal geometry
  i <- st_intersection(sf)
  # new subdivided geometry 
  subdivided <- i |> 
    filter(n.overlaps >=2) |> #get grid elements that overlap with original shape
    filter(st_geometry_type(a) %in% c("POLYGON")) # get rid of other weird line stuff
  subdivided$a
}