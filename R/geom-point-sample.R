#' Visualise Points Uncertainty
#' 
#' Identical to geom_point, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @importFrom ggplot2 aes layer_sf GeomSf coord_sf
#' @importFrom rlang list2
#' @returns A ggplot2 geom representing a sf_sample which can be added to a ggplot object
#' @export
geom_point_sample <- function() {
  }