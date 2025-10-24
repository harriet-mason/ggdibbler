#' Uncertain Count overlapping points
#' 
#' Identical to geom_count, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' 
#' @inheritParams ggplot2::geom_count
#' @importFrom ggplot2 make_constructor GeomPoint
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' @export
geom_count_sample <- make_constructor(GeomPoint, stat = "sum_sample", times=10)
