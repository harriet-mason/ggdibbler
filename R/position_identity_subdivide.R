#' @export
PositionIdentitySubdivide <- ggproto('PositionIdentitySubdivide', PositionIdentity,
                                
                                compute_layer = function(data, params, panel) {
                                  print(data)
                                  # set up values
                                  hold_drawID <- unique(data$drawID)
                                  times = max(as.numeric(hold_drawID))
                                  if(times %in% c(0, 1)) return(data)
                                  d = square_grid(times) 
                                
                                  # If multiple fills for each polygon, take a random sample of them
                                  values <- data |>
                                    select(-c(x,y)) |>
                                    group_by(group) |>
                                    summarise(fill = sample(fill, size=1),
                                              drawID = drawID,
                                              PANEL = PANEL) 
                                  print(values)
                                
                                  
                                  # Convert data into polygon (might use this later)
                                  base_polygon <- data |>
                                    dplyr::filter(drawID==1) |>
                                    dplyr::group_by(group) |>
                                    sf::st_as_sf(coords=c("x","y")) |>
                                    summarise(do_union=FALSE) |>
                                    sf::st_cast("POLYGON") 
                                  print(base_polygon)
                                  # Subdivide the polygon and convert to coordinates
                                  grid_points <- base_polygon |>
                                    group_by(group) |>
                                    dplyr::reframe(
                                      geometry = subdivide(geometry, d=d)) |>
                                    sf::st_as_sf() #|>
                                    #sf::st_coordinates() |>
                                    #as_tibble() 
                                  print(grid_points)
                                  # make group interaction of l1 and l2
                                  grid_points$group <- as.numeric(interaction(factor(grid_points$L1), factor(grid_points$L2)))
                                  
                                  # rename and remove old columns
                                  grid_points <- grid_points |>
                                    rename("x" = "X", "y" = "Y") |>
                                    select(-c(L1, L2))
                                  
                                  # Join subdivided polygon with values
                                  new_data <- grid_points |>
                                    left_join(values, by = "group") |>
                                    as.data.frame()
                                    # add draw ID back in

                                  new_data
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