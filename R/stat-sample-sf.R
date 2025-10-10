#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto StatSf ggproto_parent
#' @importFrom dplyr group_by reframe across everything mutate filter
#' @importFrom tidyselect everything
#' @importFrom sf st_sf st_zm st_make_grid st_intersection st_geometry_type
#' @importFrom distributional generate
#' @rdname geom_sf_sample
StatSampleSf <- ggproto("StatSampleSf", StatSf,
                        setup_params = function(data, params) {
                          print("stat params")
                          print(params)
                          if (is.null(params$n)) {
                            params$n = 3
                            message("Picking sample of ", params$n)
                          }
                          return(params)
                        },
                        setup_data = function(self, data, scales, coord, params, ...) {
                          # subdivide and sample data
                                 data <- data |>
                                   group_by(geometry) |>
                                   reframe(
                                     geometry = subdivide(geometry, d=c(n,n)), 
                                     across(everything())
                                   ) |>
                                   mutate(fill = as.double(generate(fill, 1))) |>
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
  nn_grid <- st_make_grid(geometry, n=d)
  # combine grid and original geometry into sf
  comb_data <- c(geometry, nn_grid)
  comb_sf <- st_sf(comb_data)
  # get interactions of grid and orginal geometry
  inter_sf <- st_intersection(comb_sf)
  # new subdivided geometry 
  subdivided <- inter_sf |> 
    filter(n.overlaps >=2) |> #get grid elements that overlap with original shape
    filter(st_geometry_type(comb_data) %in% c("POLYGON", "MULTIPOLYGON")) # get rid of other weird line stuff
  subdivided$comb_data
}