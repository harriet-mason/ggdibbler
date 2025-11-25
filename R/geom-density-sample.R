#' Visualise densities with Uncertainty
#' 
#' Identical to geom_density, except that the fill for each density will be 
#' represented by a sample from each distribution. 
#' 
#' @inheritParams ggplot2::geom_density
#' @importFrom rlang exprs arg_match0
#' @importFrom ggplot2 make_constructor GeomDensity
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' 
#' # Basic density plot
#' # GGPLOT
#' ggplot(smaller_diamonds, aes(carat)) + geom_density()
#' # GGDIBBLER
#' ggplot(smaller_uncertain_diamonds, aes(carat)) + geom_density_sample()
#' 
#' # ggplot
#' ggplot(smaller_diamonds, aes(depth, fill = cut, colour = cut)) +
#'   geom_density(alpha = 0.7) +
#'   xlim(55, 70)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(depth, fill = cut)) +
#'   geom_density_sample(aes(colour = after_stat(fill)), alpha = 0.1) +
#'   scale_x_continuous_distribution(limits=c(55, 70)) + #' ggdibbler does not have an xlim (yet)
#'   theme(palette.colour.discrete = "viridis",
#'         palette.fill.discrete = "viridis") #' bug: random variables have different colour
#' 
#'   
#' @export
geom_density_sample <- make_constructor(
  ggplot2::GeomDensity, stat = "density_sample", times = 10, outline.type = "upper",
  alpha = 1/log(times), seed = NULL,
  checks = rlang::exprs(
    outline.type <- rlang::arg_match0(outline.type, c("both", "upper", "lower", "full"))
  )
)


