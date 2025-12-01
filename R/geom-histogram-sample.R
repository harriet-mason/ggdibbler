#' Histograms and frequency polygons with uncertainty
#' 
#' Identical to geom_histogram, geom_freqpoly, and stat-bin except that 
#' it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_histogram
#' @importFrom ggplot2 make_constructor GeomBar
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @examples
#' # load ggplot
#' library(ggplot2)
#' # ggplot
#' ggplot(smaller_diamonds, aes(carat)) +
#'   geom_histogram()
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(carat)) +
#'   geom_histogram_sample() #' alpha
#' ggplot(smaller_uncertain_diamonds, aes(carat)) +
#'   geom_histogram_sample(position="identity_dodge", alpha=1) 
#' 
#' # ggplot
#' ggplot(smaller_diamonds, aes(price, colour = cut)) +
#'   geom_freqpoly(binwidth = 500)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(price, colour = cut)) +
#'   geom_freqpoly_sample(binwidth = 500)
#'  
#' # ggplot2
#' ggplot(smaller_diamonds, aes(price, fill = cut)) +
#'   geom_histogram(binwidth = 500)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(price, fill = cut)) +
#'  geom_histogram_sample(binwidth = 500)
#' 
#' 
#' @export
geom_histogram_sample <- make_constructor(ggplot2::GeomBar, stat = "bin_sample", 
                                          position = "stack_dodge", times=10, seed = NULL,
                                          binwidth = NULL, bins = NULL, orientation = NA)
