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
#' 
#' # Discrete values have overplotting
#' # ggplot
#' ggplot(mpg, aes(cty, hwy)) +
#'   geom_point()
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(cty, hwy)) +
#'   geom_point_sample()
#'
#'# Can use geom_count to fix it
#' # ggplot
#' ggplot(mpg, aes(cty, hwy)) +
#'   geom_count()
#' # ggdibbler (alpha for resample overlap)
#' ggplot(uncertain_mpg, aes(cty, hwy)) +
#'   geom_count_sample(alpha=0.2) 
#'   
#' # Best used in conjunction with scale_size_area 
#' # ggplot
#' ggplot(mpg, aes(cty, hwy)) +
#'   geom_count() +
#'   scale_size_area()
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(cty, hwy)) +
#'   geom_count_sample(alpha=0.2) +
#'   scale_size_area()
#' @export
geom_count_sample <- make_constructor(GeomPoint, stat = "sum_sample", times=10)


