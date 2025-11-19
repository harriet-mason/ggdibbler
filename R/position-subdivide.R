#' Subdivide position aesthetic in a geometry
#' 
#' If the outline of a polygon is deterministic but the fill is random,
#' you should use position subdivide rather than varying the alpha value.
#' This subdivide position can be used with geom_polygon_sample (soon to
#' be extended to others such as geom_sf, geom_map, etc).
#' 
#' @examples
#' library(ggplot2)
#' library(distributional)
#' library(dplyr)
#' 
#' # make data polygon with uncertain fill values
#' ids <- factor(c("1.1", "2.1", "1.2", "2.2", "1.3", "2.3"))
#' 
#' values <- data.frame(
#'   id = ids,
#'   value = c(1, 2, 3, 4, 5, 6)
#' )
#' positions <- data.frame(
#'   id = rep(ids, each = 4),
#'   x = c(2, 1, 1.1, 2.2, 1, 0, 0.3, 1.1, 2.2, 1.1, 1.2, 2.5, 1.1, 0.3,
#'         0.5, 1.2, 2.5, 1.2, 1.3, 2.7, 1.2, 0.5, 0.6, 1.3),
#'   y = c(-0.5, 0, 1, 0.5, 0, 0.5, 1.5, 1, 0.5, 1, 2.1, 1.7, 1, 1.5,
#'         2.2, 2.1, 1.7, 2.1, 3.2, 2.8, 2.1, 2.2, 3.3, 3.2)
#' )
#' datapoly <- merge(values, positions, by = c("id"))
#' uncertain_datapoly2 <- datapoly |>
#'   mutate(value = dist_uniform(value, value + 0.8)) 
#'   
#' # visualise with geom_polygon
#' ggplot(uncertain_datapoly2 , aes(x = x, y = y)) +
#'   geom_polygon_sample(aes(fill = value, group = id), times=50,
#'                       position = "subdivide")
#' @export
position_subdivide <- function() {
  PositionSubdivide
}

#' @rdname position_subdivide
#' @format NULL
#' @usage NULL
#' @export
PositionSubdivide <- ggproto('PositionSubdivide', PositionIdentity,

                                compute_layer = function(data, params, panel) {
                                  # set up values
                                  hold_drawID <- unique(data$drawID)
                                  times = max(as.numeric(hold_drawID))
                                  if(times %in% c(0, 1)) return(data)

                                  sample_subdivide_polygon(data, times)

                                }
)

#' @keywords internal
sample_subdivide_polygon <- function(data, times){
  d = square_grid(times) 
  
  # hold onto groups for later
  group_df <- data |>
    select(drawID, ogroup, group)
  # If multiple fills for each polygon, take a random sample of them
  values <- data |>
    dplyr::group_by(ogroup, drawID) |>
    dplyr::summarise(fill = sample(fill, size=1),
                     # panel and drawID should be constant
                     drawID = unique(drawID, size=1),
                     PANEL = unique(PANEL, size=1),
                     x = mean(x),
                     y = mean(y)) |>
    ungroup()
  # delete when worked outbug
  check1 <- values |> 
    dplyr::group_by(ogroup) |>
    summarise(val = mean(fill), 
              x = mean(x), 
              y = mean(y))
  print("polygon averages")
  print(check1)
  
  values <- values |> select(-c(x,y))
  # Convert data into polygon (might use this later)
  base_polygon <- data |>
    select(-c(fill, group)) |>
    dplyr::filter(drawID==1) |>
    dplyr::group_by(ogroup) |>
    sf::st_as_sf(coords=c("x","y")) |>
    dplyr::summarise(do_union=FALSE) |>
    sf::st_cast("POLYGON") 
  print("base polygon")
  print(base_polygon)
  
  # Subdivide the polygon and convert to coordinates
  grid_points <- base_polygon |>
    dplyr::group_by(ogroup) |>
    dplyr::reframe(
      geometry = subdivide(geometry, d=d)) |>
     sf::st_as_sf() |>
     sf::st_coordinates() |>
     tibble::as_tibble() 
  # Used to have make group interaction of l1 and l2, I 
  grid_points$ogroup <-  1 + (grid_points$L2-1) %/% times
  
  print("grid points")
  print(grid_points |> group_by(ogroup) |> summarise(X = mean(X), Y = mean(Y)))
  
  # rename and remove old columns
  grid_points <- grid_points |>
    dplyr::rename("x" = "X", "y" = "Y") |>
    dplyr::select(-c(L1, L2))
  # Join subdivided polygon with values
  print("values")
  print(head(values))
  new_data <- grid_points |>
    dplyr::left_join(values, by = "ogroup") |>
    dplyr::left_join(group_df, by = c("ogroup", "drawID")) |>
    as.data.frame()
  # add draw ID back in
  print(head(new_data))
  check <- new_data |> 
    dplyr::group_by(ogroup) |>
    summarise(val = mean(fill), 
              x = mean(x), 
              y = mean(y))
  print("final averages")
  print(check)
  
  new_data
}

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


# Internal function for subdividing geometry grid
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

# Internal function for finding the "most square" factors of a number
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
