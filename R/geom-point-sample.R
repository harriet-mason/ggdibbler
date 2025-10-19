#' Visualise Points Uncertainty
#' 
#' Identical to geom_point, except that it will accept a distribution in place of any of the usual aesthetics.

#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
#' @importFrom ggplot2 aes layer GeomPoint
#' @importFrom rlang list2
#' @importFrom dplyr rename_with
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_point
#' @examples
#' # In it's most basic form, the geom will make a subdivision 
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' set.seed(1997)
#' point_data <- data.frame(
#'   random_x = c(distributional::dist_uniform(2,3),
#'                distributional::dist_normal(3,2), 
#'              distributional::dist_exponential(3)),
#'   random_y = c(distributional::dist_gamma(2,1),
#'              dist_sample(x = list(rnorm(100, 5, 1))),
#'              distributional::dist_exponential(1)),
#'    # have some uncertainty as to which category each value belongs to
#'   random_colour = dist_categorical(prob = list(c(0.8,0.15,0.05),
#'                                                  c(0.25,0.7,0.05),
#'                                                  c(0.25,0,0.75)), 
#'                                      outcomes = list(c("A", "B", "C"))),
#'   deterministic_xy = c(1,2,3),
#'   deterministic_colour = c("A", "B", "C"))
#'  
#' # check the data to see the random variables
#' point_data
#'   
#' # basic random variables x and y
#' ggplot() + 
#'   geom_point_sample(data = point_data, ggplot2::aes(x=random_x, y=random_y))
#'
#' # random variables only x
#' ggplot() + 
#'   geom_point_sample(data = point_data, ggplot2::aes(x=random_x, y=deterministic_xy), 
#'                     alpha = 0.3, times=50)
#'   
#' # deterministic colour, random x and y
#' ggplot() + 
#'   geom_point_sample(data = point_data, ggplot2::aes(x=random_x, y=random_y, colour = deterministic_colour))
#'   
#' # random x, y, and colour
#' ggplot() + 
#'   geom_point_sample(data = point_data, ggplot2::aes(x=random_x, y=random_y, colour = random_colour), 
#'                     times=1000, alpha=0.3)
#' @export
geom_point_sample <- function(mapping = NULL, data = NULL, stat = "identity", position = "identity",
                              na.rm = FALSE, times=30, show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    data = data, 
    mapping = mapping, 
    geom = GeomPointSample, 
    stat = StatSample, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list2(
      na.rm = na.rm,
      times = times,
      ...
    )
  )
}
#' @keywords internal
GeomPointSample <- ggproto("GeomPointSample", GeomPoint,
                           required_aes = c("x|xdist", "y|ydist")
                           )


