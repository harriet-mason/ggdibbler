#' Uncertain hexagonal heatmap of 2d bin counts
#' 
#' Identical to geom_hex, except that it will accept a distribution in place of 
#' any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_hex
#' @importFrom ggplot2 make_constructor GeomHex
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @examples
#' library(ggplot2)
#' d <- ggplot(smaller_diamonds, aes(carat, price))
#' d + geom_hex()
#' 
#' b <- ggplot(smaller_uncertain_diamonds, aes(carat, price))
#' b + geom_hex_sample(alpha=0.15)
#' 
#' # You still have access to all the same parameters
#' d + geom_hex(bins = 10)
#' b + geom_hex_sample(bins = 10, alpha=0.15)
#' @export
geom_hex_sample <- make_constructor(ggplot2::GeomHex, stat = "bin_hex_sample", 
                                    times=10, seed = NULL, alpha=0.5/log(times))
