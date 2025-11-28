#' Violin plots with uncertainty
#' 
#' Identical to geom_violin, except that it will accept a distribution in
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_violin
#' @inheritParams ggplot2::stat_ydensity
#' @importFrom ggplot2 make_constructor GeomViolin
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' 
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' 
#' # plot set up
#' p <- ggplot(mtcars, 
#'   aes(factor(cyl), mpg))
#' q <- ggplot(uncertain_mtcars, 
#'   aes(dist_transformed(cyl, factor, as.numeric), mpg))
#' 
#' # ggplot
#' p + geom_violin()
#' # ggdibbler
#' q + geom_violin_sample()
#'
#' # Default is to trim violins to the range of the data. To disable:
#' # ggplot
#' p + geom_violin(trim = FALSE)
#' # ggdibbler
#' q + geom_violin_sample(trim = FALSE)
#' 
#' @export
geom_violin_sample <- make_constructor(ggplot2::GeomViolin, stat = "ydensity_sample", 
                                       times=10, alpha = 1/log(times), seed = NULL)
