#' Uncertain heatmap of 2d bin counts
#' 
#' Identical to geom_bin_2d, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_bin_2d
#' @importFrom ggplot2 make_constructor GeomBin2d
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' # ggplot
#' library(ggplot2)
#' d <- ggplot(smaller_diamonds, aes(x, y)) 
#' d + geom_bin_2d()
#' # ggdibbler
#' b <- ggplot(smaller_uncertain_diamonds, aes(x, y)) 
#' # the ggdibbler default position adjustment is dodging
#' b + geom_bin_2d_sample(times=100)
#' # but it can change it to be transparency
#' b + geom_bin_2d_sample(position="identity", alpha=0.2)
#' # Still have the same options
#' d + geom_bin_2d(bins = 10) #ggplot
#' b + geom_bin_2d_sample(bins = 10) #ggdibbler
#' @export
geom_bin_2d_sample <- make_constructor(ggplot2::GeomBin2d, stat = "bin2d_sample", 
                                       times=10, position="identity_dodge")
