#' Histograms and frequency polygons with uncertainty
#' 
#' Identical to geom_histogram, geom_freqpoly, and stat-bin except that 
#' it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_histogram
#' @importFrom ggplot2 make_constructor GeomBar
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' # load ggplot
#' library(ggplot2)
#' # ggplot
#' ggplot(smaller_diamonds, aes(carat)) +
#'   geom_histogram()
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(carat)) +
#'   geom_histogram_sample(alpha=0.1) #' alpha
#' ggplot(smaller_uncertain_diamonds, aes(carat)) +
#'   geom_histogram_sample(position="dodge") #' dodge
#' 
#' # ggplot
#' ggplot(smaller_diamonds, aes(carat)) +
#'   geom_histogram(binwidth = 0.01)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(carat)) +
#'   geom_histogram_sample(binwidth = 0.01, alpha=0.2)
#' 
#' # ggplot
#' ggplot(smaller_diamonds, aes(carat)) +
#'   geom_histogram(bins = 200)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(carat)) +
#'   geom_histogram_sample(bins = 200, alpha=0.2)
#' 
#' 
#' # Map values to y to flip the orientation
#' # ggplot
#' ggplot(smaller_diamonds, aes(y = carat)) +
#'   geom_histogram()
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(y = carat)) +
#'   geom_histogram_sample(alpha=0.2)
#' 
#' # ggplot
#' ggplot(smaller_diamonds, aes(price, colour = cut)) +
#'   geom_freqpoly(binwidth = 500)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(price, colour = cut)) +
#'   geom_freqpoly_sample(binwidth = 500, alpha=0.5)
#' 
#' # To make it easier to compare distributions with very different counts,
#' # put density on the y axis instead of the default count
#' # ggplot
#' ggplot(smaller_diamonds, aes(price, after_stat(density), colour = cut)) +
#'   geom_freqpoly(binwidth = 500)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(price, after_stat(density), colour = cut)) +
#'   geom_freqpoly_sample(binwidth = 500, alpha=0.5)
#' 
#' # You can specify a function for calculating binwidth, which is
#' # particularly useful when faceting along variables with
#' # different ranges because the function will be called once per facet
#' # ggplot
#' ggplot(economics_long, aes(value)) +
#'   facet_wrap(~variable, scales = 'free_x') +
#'   geom_histogram(binwidth = \(x) 2 * IQR(x) / (length(x)^(1/3)))
#' # ggdibbler
#' ggplot(uncertain_economics_long, aes(value)) +
#'   facet_wrap(~variable, scales = 'free_x') +
#'   geom_histogram_sample(binwidth = \(x) 2 * IQR(x) / (length(x)^(1/3)), 
#'                         alpha=0.2)
#' @export
geom_histogram_sample <- make_constructor(ggplot2::GeomBar, stat = "bin_sample", #position = "stack",
                                    times=10, binwidth = NULL, bins = NULL, orientation = NA)
