#' Visualise Points Uncertainty
#' 
#' Identical to geom_point, except that it will accept a distribution in place of any of the usual aesthetics.

#' @param n A parameter used to control the number of values sampled from each distribution.
#' @importFrom ggplot2 aes layer GeomPoint
#' @importFrom rlang list2
#' @importFrom dplyr rename_with
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @export
geom_sample_point <- function(mapping = NULL, data = NULL, stat = "identity", position = "identity",
                              na.rm = FALSE, n=30, show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    data = data, 
    mapping = mapping, 
    geom = GeomPoint, 
    stat = stat, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list2(
      na.rm = na.rm,
      n = n,
      ...
    )
  )
}

