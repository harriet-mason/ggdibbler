#' Visualise Densities with Uncertainty
#' 
#' Identical to geom_density, except that the fill for each density will be represented by
#' a sample from each distribution. 
#' 
#' @inheritParams ggplot2::geom_density
#' @importFrom rlang exprs arg_match0
#' @importFrom ggplot2 make_constructor GeomDensity
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' ggplot(mpg, aes(hwy)) + geom_density() #ggplot
#' ggplot(uncertain_mpg, aes(hwy)) + geom_density_sample() #ggdibbler
geom_density_sample <- make_constructor(
  ggplot2::GeomDensity, stat = "density_sample", times = 10, outline.type = "upper",
  checks = rlang::exprs(
    outline.type <- rlang::arg_match0(outline.type, c("both", "upper", "lower", "full"))
  )
)


