#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto StatSf ggproto_parent
#' @importFrom dplyr group_by reframe across everything mutate filter
#' @importFrom tidyselect everything
#' @importFrom sf st_sf st_zm st_make_grid st_intersection st_geometry_type
#' @importFrom distributional generate
#' @rdname geom_sf_sample
StatSfSample <- ggproto("StatSfSample", StatSf,
                        setup_data = function(data, params) {
                          sample_subdivide_sf(data, params$times)
                        },
                        # This is just here so setup_data has access to n
                        compute_panel = function(self, data, scales, coord, times) {
                          ggproto_parent(StatSf, self)$compute_panel(data, scales, coord)
                          },
                        required_aes = c("geometry")
                        
)

# Sample expand for sf objects
sample_subdivide_sf <- function(data, times){ 
  d <- square_grid(times)
  data |>
    group_by(geometry) |>
    reframe(
      geometry = subdivide(geometry, d=d), 
      across(everything())
    ) |>
    mutate(fill = as.double(generate(fill, 1))) |>
    st_sf() |>
    st_zm()
}


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


