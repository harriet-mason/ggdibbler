#' @export
PositionIdentitySubdivide <- ggproto('PositionIdentitySubdivide', PositionIdentity,
                                
                                compute_layer = function(data, params, panel) {
                                  times = max(as.numeric(data$drawID))
                                  gridd = square_grid(times) + 1
                                  
                                  data <- data |>
                                    dplyr::mutate(sub_group = as.factor(1 + as.numeric(drawID) %% as.numeric(group)))
                                  
                                  the_grid <- data |>
                                    group_by(sub_group) |>
                                    filter(drawID==1) |>
                                    reframe(x = subdivide_x(x, gridd),
                                            y = subdivide_y(y, gridd))
                                  print(the_grid)
                                
                                  #data <- data |>
                                  #  dplyr::group_by(sub_group)|>
                                  #  dplyr::summarise(
                                  #    x = subdivide_xy(x, gridd[2]), 
                                  #    y = subdivide_xy(y, gridd[1]),
                                  #    dplyr::across(dplyr::everything()))
                                  #print(data)
                                  data
                                }
)
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