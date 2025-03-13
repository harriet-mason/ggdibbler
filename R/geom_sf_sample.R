#' Visualise Sf Objectjects with Uncertainty
#' 
#' Identical to geom_sf, except that the fill for each area will be a distribution. 
#' This function will replace the fill area with a grid, where each cell is filled with an outcome from the fill distribution. 
#' 
#' @param n A parameter used to control the number of cells in each grid. Each area is broken up into an nxn grid
#' @param fill A variable of distributions from the `distributional` package
#' @returns A ggplot2 geom representing a sf_sample which can be added to a ggplot object
#' @examples
#' # In it's most basic form, the geom will make a subdivision 
#' library(ggplot2)
#' toymap |>  
#'   ggplot() + 
#'   geom_sf_sample(aes(geometry = geometry, fill=temp_dist))
#' # The original borders of the sf object can be hard to see, 
#'  # so layering the original geometry on top can help to see the original boundaries
#' toymap |>  
#'   ggplot() + 
#'   geom_sf_sample(aes(geometry = geometry, fill=temp_dist), linewidth=0.1, n=5) + 
#'   geom_sf(aes(geometry=geometry), fill=NA, linewidth=1)
#' @export
geom_sf_sample <- function(mapping = ggplot2::aes(), data = NULL, stat = "sample",
                           position = "identity", na.rm = FALSE, show.legend = NA,
                           inherit.aes = TRUE, n = NULL, ...) {
  c(
    ggplot2::layer_sf(
      geom = ggplot2::GeomSf,
      data = data,
      mapping = mapping,
      stat = stat,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = rlang::list2(
        na.rm = na.rm,
        n = n,
        ...
      )
    ),
    ggplot2::coord_sf(default = TRUE)
  )
}



