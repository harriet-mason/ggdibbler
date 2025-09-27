#' Visualise Points Uncertainty
#' 
#' Identical to geom_point, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @importFrom ggplot2 aes layer GeomPoint
#' @importFrom rlang list2
#' @importFrom dplyr rename_with
#' @returns A ggplot2 geom representing a sf_sample which can be added to a ggplot object
#' @export
geom_point_sample <- function(mapping = NULL, data = NULL, position = "identity", 
                       ..., na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  capture_and_filter_warnings({
  ggplot2::layer(
    data = data, 
    mapping = mappingswap(mapping, data), 
    geom = GeomPoint, 
    stat = StatSample, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm, ...)
  )
  })
}

