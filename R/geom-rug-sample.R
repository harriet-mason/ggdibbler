#' Uncertain Rug plots in the margins
#' 
#' Identical to geom_rug, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' 
#' @inheritParams ggplot2::geom_rug
#' @importFrom ggplot2 make_constructor GeomRug
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' 
#' point_data <- data.frame(
#'   random_x = c(dist_uniform(2,3),
#'                dist_normal(3,2), 
#'              dist_exponential(3)),
#'   random_y = c(dist_gamma(2,1),
#'              dist_sample(x = list(rnorm(100, 5, 1))),
#'              dist_exponential(1)),
#'    # have some uncertainty as to which category each value belongs to
#'   random_colour = dist_categorical(prob = list(c(0.8,0.15,0.05),
#'                                                  c(0.25,0.7,0.05),
#'                                                  c(0.25,0,0.75)), 
#'                                      outcomes = list(c("A", "B", "C"))),
#'   deterministic_xy = c(1,2,3),
#'   deterministic_colour = c("A", "B", "C"))
#'   
#' # basic random variables x and y
#' ggplot() + 
#'   geom_point_sample(data = point_data, aes(x=random_x, y=random_y)) +
#'   geom_rug_sample(data = point_data, aes(x=random_x, y=random_y))
#'
#' 
#' @export
geom_rug_sample <- make_constructor(GeomRug, stat = "sample", times=30)