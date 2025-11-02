#' @export
PositionIdentitySubdivide <- ggproto('PositionIdentitySubdivide', PositionIdentity,
                                
                                compute_layer = function(data, params, panel) {
                                  hold_drawID <- unique(data$drawID)
                                  times = max(as.numeric(hold_drawID))
                                  if(times == 0) return(data)
                                  d = square_grid(times) 
                                
                                  the_grid <- data |>
                                    dplyr::mutate(sub_group = 
                                                    as.factor(1 + as.numeric(drawID) %% as.numeric(group)))|>
                                    dplyr::filter(drawID==1) |>
                                    dplyr::group_by(sub_group) |>
                                    sf::st_as_sf(coords=c("x","y"))|>
                                    dplyr::summarise() %>%
                                    sf::st_cast("POLYGON") |>
                                    dplyr::reframe(
                                      geometry = subdivide(geometry, d=d), 
                                      sub_group = sub_group,
                                      dplyr::across(dplyr::everything())
                                    ) #|> 
                                    #sf::st_as_sfc() |>
                                    #sf::st_cast("POLYGON") |>
                                    #sf::st_sf() #|>
                                    #sf::st_zm()
                                    #st_cast("POLYGON") #|>
                                    #dplyr::mutate(drawID = hold_drawID)
                                    
                                    
                                    
                                  #the_grid <- subdivide(the_grid$geometry , d)
                          
                                  #ggplot2::ggplot(the_grid, ggplot2::aes(x = x, y = y, group=sub)group) +
                                  #  ggplot2::geom_polygon()
                                  #data <- data |>
                                  #  dplyr::group_by(sub_group)|>
                                  #  dplyr::summarise(
                                  #    x = subdivide_xy(x, gridd[2]), 
                                  #    y = subdivide_xy(y, gridd[1]),
                                  #    dplyr::across(dplyr::everything()))
                                  the_grid
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
  comb_sf <- sf::st_sf(comb_data) |>
    sf::st_make_valid()
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

subdivide_y <- function(y , gridd){
  npoints = prod(gridd)
  y <- seq(from = min(y), to = max(y), length.out = gridd[1])
  y <- rep(y, times = gridd[2])
  return(y)
}

subdivide_x <- function(x, gridd){
  npoints = prod(gridd)
  x <- seq(from = min(x), to = max(x), length.out = gridd[2])
  x <- rep(x, each = gridd[1])
  return(x)
}