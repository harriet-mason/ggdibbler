#' Quantile regression with uncertainty
#' 
#' Identical to geom_quantile, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_quantile
#' @importFrom ggplot2 make_constructor GeomQuantile
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' # ggplot
#' m <- ggplot(mpg, aes(displ, hwy)) +
#'   geom_point()
#' # ggdibbler
#' n <- ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample()
#' # ggplot
#' m + geom_quantile()
#' # ggdibbler
#' n + geom_quantile_sample()
#' 
#' # ggplot
#' m + geom_quantile(quantiles = 0.5)
#' # ggdibbler
#' n + geom_quantile_sample(quantiles = 0.5)
#' @export
geom_quantile_sample <- make_constructor(ggplot2::GeomQuantile, stat = "quantile_sample", 
                                         times=10, alpha = 1/log(times), seed = NULL)
