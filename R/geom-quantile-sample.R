#' Quantile regression with uncertainty
#' 
#' Identical to geom_quantile, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_quantile
#' @importFrom ggplot2 make_constructor GeomQuantile
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' # ggplot
#' m <- ggplot(mpg, aes(displ, hwy)) +
#'   geom_point()
#' # ggdibbler
#' n <- ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(size=1, alpha=0.2)
#' # ggplot
#' m + geom_quantile()
#' # ggdibbler
#' n + geom_quantile_sample(alpha=0.5, linewidth=0.5)
#' 
#' # ggplot
#' m + geom_quantile(quantiles = 0.5)
#' # ggdibbler
#' n + geom_quantile_sample(quantiles = 0.5, 
#'                          alpha=0.5, linewidth=0.5)
#' 
#' q10 <- seq(0.05, 0.95, by = 0.05)
#' # ggplot
#' m + geom_quantile(quantiles = q10)
#' # ggdibbler
#' n + geom_quantile_sample(quantiles = q10, alpha=0.5, linewidth=0.5)
#' 
#' # You can also use rqss to fit smooth quantiles
#' # ggplot
#' m + geom_quantile(method = "rqss")
#' # ggdibbler
#' n + geom_quantile_sample(method = "rqss",
#'                          alpha=0.5, linewidth=0.5)
#' 
#' # Note that rqss doesn't pick a smoothing constant automatically, so
#' # you'll need to tweak lambda yourself
#' # ggplot
#' m + geom_quantile(method = "rqss", lambda = 0.1)
#' # ggdibbler
#' n + geom_quantile_sample(method = "rqss", lambda = 0.1,
#'                          alpha=0.5, linewidth=0.5)
#' 
#' # Set aesthetics to fixed value
#' # ggplot
#' m + geom_quantile(colour = "red", linewidth = 2, alpha = 0.5)
#' # ggdibbler
#' n + geom_quantile_sample(colour = "red", linewidth = 2, alpha = 0.5)
#' @export
geom_quantile_sample <- make_constructor(ggplot2::GeomQuantile, stat = "quantile_sample", 
                                         times=10)
