#' Visualise Sf Objects with Uncertainty
#' 
#' Identical to geom_sf, except that the fill for each area will be a distribution. 
#' This function will replace the fill area with a grid, where each cell is filled 
#' with an outcome from the fill distribution. 
#' 
#' @importFrom ggplot2 aes layer_sf GeomSf coord_sf
#' @importFrom rlang list2
#' @importFrom lifecycle deprecated is_present deprecate_soft
#' @param n Deprecated in favour of times.
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @returns A ggplot2 geom representing a sf_sample which can be added to a 
#' ggplot object
#' @inheritParams ggplot2::geom_sf
#' @examples
#' # In it's most basic form, the geom will make a subdivision 
#' library(ggplot2)
#' library(dplyr)
#' library(sf)
#' basic_data <- toy_temp_dist |>
#'   filter(county_name %in% c("Pottawattamie County", "Mills County", "Cass County"))
#' basic_data |>
#'   ggplot() + 
#'   geom_sf_sample(times=100, linewidth=0,
#'                  aes(geometry = county_geometry, fill=temp_dist))
#' # The original borders of the sf object can be hard to see, 
#'  # so layering the original geometry on top can help to see the original boundaries
#' basic_data |>  
#'   ggplot() + 
#'   geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist), linewidth=0, times=100) + 
#'   geom_sf(aes(geometry=county_geometry), fill=NA, linewidth=1)
#' @export
geom_sf_sample <- function(mapping = aes(), data = NULL, 
                           position = "subdivide", na.rm = FALSE, show.legend = NA,
                           inherit.aes = TRUE, times = 10, seed = NULL,
                           n = deprecated(), ...) {
  if (is_present(n)) {
    
    # Signal the deprecation to the user
    deprecate_soft("0.2.0", "ggdibbler::geom_sf_sample(n = )", "ggdibbler::geom_sf_sample(times = )")
    
    # Deal with the deprecated argument for compatibility
    times <- n^2
  }
  
  c(
    layer_sf(
      geom = GeomSf,
      data = data,
      mapping = mapping,
      stat = StatSfSample,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list2(
        seed = seed,
        na.rm = na.rm,
        times = times,
        ...
      )
    ),
    coord_sf(default = TRUE)
  )
}





