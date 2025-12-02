#' Subdivide position aesthetic in a geometry
#' 
#' If the outline of a polygon is deterministic but the fill is random,
#' you should use position subdivide rather than varying the alpha value.
#' This subdivide position can be used with geom_polygon_sample (soon to
#' be extended to others such as geom_sf, geom_map, etc).
#' 
#' @returns A ggplot2 position
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
#' uncertain_datapoly <- datapoly |>
#'   mutate(value = dist_uniform(value, value + 0.8)) 
#'   
#' # ggplot
#' ggplot(datapoly , aes(x = x, y = y)) +
#'   geom_polygon(aes(fill = value, group = id)) 
#'   
#' # ggdibbler
#' ggplot(uncertain_datapoly , aes(x = x, y = y)) +
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
                                  # If 1 or 0 draws, only draw once
                                  times = max(as.numeric(data$drawID))
                                  if(times %in% c(0, 1)) return(data)
                                  
                                  # Check if polygon or SF
                                  if("geometry" %in% names(data)) {
                                    sample_subdivide_sf(data, times)
                                  } else {
                                    sample_subdivide_polygon(data, times)
                                  }
                                }
)

#' @keywords internal
sample_subdivide_polygon <- function(data, times){
  # get grid dimensions for subdivide
  d = square_grid(times) 
  
  # If multiple fills for each polygon, take a random sample of them
  values <- data |>
    dplyr::group_by(ogroup, drawID, group) |>
    dplyr::summarise(fill = sample(fill, size=1),
                     # panel and drawID should be constant
                     drawID = unique(drawID, size=1),
                     PANEL = unique(PANEL, size=1)) |>
    ungroup()
  
  # Convert data into polygon (might use this later)
  base_polygon <- data |>
    select(-c(fill, group)) |>
    dplyr::filter(drawID==1) |>
    dplyr::group_by(ogroup) |>
    sf::st_as_sf(coords=c("x","y")) |>
    dplyr::summarise(do_union=FALSE) |>
    sf::st_cast("POLYGON") 
  
  # Subdivide the polygon and convert to coordinates
  g <- base_polygon$ogroup
  groups <- split(base_polygon, g)
  new_g <- NULL
  new_polygons <- lapply(groups, function(geometry){
    ogroup <- geometry$ogroup
    new <- geometry |>
      dplyr::reframe(
        geometry = subdivide(geometry, d=d)
        ) |>
      sf::st_as_sf() |>
      sf::st_coordinates() |>
      as.data.frame(new) |>
      mutate(drawID = factor(L2),
             ogroup = ogroup) |>
      dplyr::rename("x" = "X", 
                    "y" = "Y") |>
      dplyr::select(-c(L1, L2))
    new
  })
  grid_points <- dplyr::bind_rows(new_polygons)
  
  # Join subdivided polygon with values
  new_data <- grid_points |>
    dplyr::left_join(values, by = c("ogroup", "drawID")) |>
    as.data.frame()
  new_data
}

#' @keywords internal
sample_subdivide_sf <- function(data, times){ 
  # add geometry ID for rejoining later
  data <- data |> 
    dplyr::group_by(geometry) |>
    dplyr::mutate(geometryID = cur_group_id()) |>
    dplyr::ungroup()
  
  # make grid for subdivision
  d <- square_grid(times)
  
  # subdivide geometries
  # must do separately in case grid cells =/= times
  geometries <- data |>
    dplyr::select(geometry, group, geometryID) |>
    dplyr::group_by(geometry, geometryID) |>
    dplyr::reframe(geometry = subdivide(unique(geometry), d=d),
                   group = group[1:length(geometry)]) |>
    dplyr::ungroup()
  
  # remove old geometry column
  old_data <- data |>
    tibble::as_tibble() |>
    dplyr::select(-geometry)
  
  # recombine fill values with geometry column
  dplyr::left_join(geometries, old_data, by = c("geometryID", "group"))
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
