#' Visualise Sf Objectjects with Uncertainty
#' 
#' Identical to geom_sf, except that the fill for each area will be a distribution. 
#' This function will replace the fill area with a grid, where each cell is filled with an outcome from the fill distribution. 
#' 
#' @importFrom ggplot2 aes layer_sf GeomSf coord_sf
#' @importFrom rlang list2
#' @param n A parameter used to control the number of cells in each grid. Each area is broken up into an nxn grid
#' @returns A ggplot2 geom representing a sf_sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_sf
#' @examples
#' # In it's most basic form, the geom will make a subdivision 
#' library(ggplot2)
#' library(dplyr)
#' basic_data <- toy_temp_dist |>
#' dplyr::filter(county_name %in% c("Pottawattamie County", "Mills County", "Cass County"))
#' basic_data |>
#'   ggplot() + 
#'   geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist))
#' # The original borders of the sf object can be hard to see, 
#'  # so layering the original geometry on top can help to see the original boundaries
#' basic_data |>  
#'   ggplot() + 
#'   geom_sf_sample(aes(geometry = county_geometry, fill=temp_dist), linewidth=0.1, n=4) + 
#'   geom_sf(aes(geometry=county_geometry), fill=NA, linewidth=1)
#' @export
geom_sf_sample <- function(mapping = aes(), data = NULL, stat = "sample",
                           position = "identity", na.rm = FALSE, show.legend = NA,
                           inherit.aes = TRUE, n = NULL, ...) {
  c(
    layer_sf(
      geom = GeomSf,
      data = data,
      mapping = mapping,
      stat = stat,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list2(
        na.rm = na.rm,
        n = n,
        ...
      )
    ),
    coord_sf(default = TRUE)
  )
}



