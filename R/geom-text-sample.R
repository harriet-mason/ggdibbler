#' Uncertain Text
#' 
#' Identical to geom_text, except that it will accept a distribution in place of any of the usual aesthetics.
#' See the documentation of `ggplot2::geom_text` for more details.
#' 
#' @importFrom ggplot2 make_constructor GeomText
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_text
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
#' 
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
#'   geom_text_sample(data = point_data, aes(x=random_x, y=random_y, colour = deterministic_colour,
#'                                       label = deterministic_colour))
#'
#' # can also take random labels 
#' ggplot() + 
#'   geom_text_sample(data = point_data, aes(x=random_x, y=random_y, colour = after_stat(label),
#'                                       label = random_colour))
#' # if you want colour to be the same, you need to use after_stat(label)
#' # otherwise the two aesthetics will be sampled independently
#' 
#' @export
geom_text_sample <- make_constructor(GeomText, position = "nudge", stat = "sample", times=30)




