#' Visualise Densities with Uncertainty
#' 
#' Identical to geom_density, except that the fill for each density will be represented by
#' a sample from each distribution. 
#' 
#' @inheritParams ggplot2::geom_density
#' @importFrom ggplot2 make_constructor GeomDensity
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot)
#' ggplot(mpg, aes(hwy)) + geom_density() #ggplot
#' ggplot(uncertain_mpg, aes(hwy)) + geom_density_sample() #ggdibbler
geom_density_sample <- ggplot2::make_constructor(
  GeomDensity, stat = "density_sample", times = 10
)

