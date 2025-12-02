#' Visualise Uncertain Points
#' 
#' Identical to geom_point, except that it will accept a distribution in place 
#' of any of the usual aesthetics.
#' 
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @importFrom ggplot2 make_constructor GeomPoint
#' @returns A ggplot2 layer
#' @inheritParams ggplot2::geom_point
#' @examples
#' library(ggplot2)
#' library(distributional)
#' 
#'   # ggplot
#' p <- ggplot(mtcars, aes(wt, mpg))
#' p + geom_point()
#' 
#'   # ggdibbler - set the sample size with times
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg))
#' q + geom_point_sample(times=50) 
#' 
#' # Add aesthetic mappings
#' 
#'  # ggplot
#' p + geom_point(aes(colour = factor(cyl)))
#'   # ggdibbler - a
#' q + geom_point_sample(aes(colour = dist_transformed(cyl, factor, as.numeric))) +
#' labs(colour = "factor(cyl)")
#'  # ggplot
#' p + geom_point(aes(shape = factor(cyl))) 
#'   # ggdibbler
#' q + geom_point_sample(aes(shape = dist_transformed(cyl, factor, as.numeric))) + 
#' labs(shape = "factor(cyl)")
#'  
#' # A "bubblechart":
#' # ggplot2
#' p + geom_point(aes(size = qsec))
#' # ggdibbler
#' q + geom_point_sample(aes(size = qsec), alpha=0.1)
#' @export
geom_point_sample <- make_constructor(GeomPoint, stat = "identity_sample", 
                                      times=10, seed = NULL,
                                      alpha=1/log(times))
