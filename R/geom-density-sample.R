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
#' library(ggplot)
#' 
#' # make diamonds data smaller because otherwise there is no uncertainty and takes too long
#' set.seed(248)
#' index <- sample(nrow(uncertain_diamonds), size = 100)
#' smaller_diamonds <- diamonds[index,]
#' smaller_uncertain_diamonds <- uncertain_diamonds[index,]
#' 
#' # Basic density plot
#' # GGPLOT
#' ggplot(smaller_diamonds, aes(carat)) + geom_density()
#' 
#' # GGDIBBLER
#' ggplot(smaller_uncertain_diamonds, aes(carat)) + geom_density_sample()
geom_density_sample <- make_constructor(
  ggplot2::GeomDensity, stat = "density_sample", times = 10, outline.type = "upper",
  checks = rlang::exprs(
    outline.type <- rlang::arg_match0(outline.type, c("both", "upper", "lower", "full"))
  )
)


