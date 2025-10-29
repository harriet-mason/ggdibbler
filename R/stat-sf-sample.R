#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto StatSf ggproto_parent
#' @importFrom distributional generate
#' @rdname geom_sf_sample
StatSfSample <- ggproto("StatSfSample", StatSf,
                        setup_data = function(data, params) {
                          sample_subdivide_sf(data, params$times)
                        },
                        # This is just here so setup_data has access to n
                        extra_params = c("na.rm", "times"),
                        compute_panel = function(self, data, scales, coord, times) {
                          ggproto_parent(StatSf, self)$compute_panel(data, scales, coord)
                          }
                        
)


#' @keywords internal
sample_subdivide_sf <- function(data, times){ 
  d <- square_grid(times)
  data |>
    dplyr::group_by(geometry) |>
    dplyr::reframe(
      geometry = subdivide(geometry, d=d), 
      dplyr::across(dplyr::everything())
    ) |>
    dplyr::mutate(fill = as.double(generate(fill, 1))) |>
    sf::st_sf() |>
    sf::st_zm()
}


#'  Internal function for subdividing geometry grid
#'  
#' @keywords internal
subdivide <- function(geometry, d){
  n.overlaps <- NULL #to avoid binding error
  # make n*n grid
  nn_grid <- sf::st_make_grid(geometry, n=d)
  # combine grid and original geometry into sf
  comb_data <- c(geometry, nn_grid)
  comb_sf <- sf::st_sf(comb_data)
  # get interactions of grid and orginal geometry
  inter_sf <- sf::st_intersection(comb_sf)
  # new subdivided geometry 
  subdivided <- inter_sf |> 
    dplyr::filter(n.overlaps >=2) |> #get grid elements that overlap with original shape
    dplyr::filter(sf::st_geometry_type(comb_data) %in% c("POLYGON", "MULTIPOLYGON")) # get rid of other weird line stuff
  subdivided$comb_data
}

#'  Internal function for finding the "most square" factors of a number
#'  
#' @keywords internal
square_grid <- function(x) {
  # get factors
  x <- as.integer(x)
  div <- seq_len(abs(x))
  factors <- div[x %% div == 0L]
  
  # midpoint
  mid <- length(factors)%/%2
  
  # if odd, middle number is square, return square factor
  if(length(factors)%%2==1) return(rep(factors[mid+1],2))
  
  # If even, get middle factors that are not
  grid <- factors[c(mid, mid+1)]
  
  # Maybe include a check to make values more square?
  return(grid)
}


