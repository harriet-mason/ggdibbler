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
#' 
#' # Basic density plot
#' # GGPLOT
#' ggplot(smaller_diamonds, aes(carat)) + geom_density()
#' # GGDIBBLER
#' ggplot(smaller_uncertain_diamonds, aes(carat)) + geom_density_sample()
#' 
#' # Flipped orientation
#' # GGPLOT
#' ggplot(smaller_diamonds, aes(y = carat)) +
#'   geom_density()
#' # GGDIBBLER
#' ggplot(smaller_uncertain_diamonds, aes(y = carat)) +
#'   geom_density_sample()
#' 
#' # Adjust smoothness
#' #GGPLOT
#' ggplot(smaller_diamonds, aes(carat)) +
#'   geom_density(adjust = 1/5)
#' #GGDIBBLER
#' ggplot(smaller_uncertain_diamonds, aes(carat)) +
#'   geom_density_sample(adjust = 1/5)

#' # ggplot
#' ggplot(smaller_diamonds, aes(depth, colour = cut)) +
#'   geom_density_sample() +
#'   xlim(55, 70)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(depth, colour = cut)) +
#'   geom_density_sample() +
#'   scale_x_continuous_distribution(limits=c(55, 70)) + #' ggdibbler does not have an xlim (yet)
#'   theme(palette.colour.discrete = "viridis") #' bug: random variables have different colour
#' 
#' # ggplot
#' ggplot(smaller_diamonds, aes(depth, fill = cut, colour = cut)) +
#'   geom_density(alpha = 0.1) +
#'   xlim(55, 70)
#' # ggdibbler
#' ggplot(smaller_uncertain_diamonds, aes(depth, fill = cut)) +
#'   geom_density_sample(aes(colour = after_stat(fill)), alpha = 0.1) +
#'   scale_x_continuous_distribution(limits=c(55, 70)) + #' ggdibbler does not have an xlim (yet)
#'   theme(palette.colour.discrete = "viridis",
#'         palette.fill.discrete = "viridis") #' bug: random variables have different colour
#' 
#' # Use `bounds` to adjust computation for known data limits
#' big_diamonds <- smaller_diamonds[smaller_diamonds$carat >= 1, ]
#' big_uncertain_diamonds <- smaller_uncertain_diamonds[smaller_diamonds$carat >= 1, ]
#' # ggplot
#' ggplot(big_diamonds, aes(carat)) +
#'   geom_density(color = 'red') +
#'   geom_density(bounds = c(1, Inf), color = 'blue')
#' # ggplot
#' ggplot(big_uncertain_diamonds, aes(carat)) +
#'   geom_density_sample(color = 'red') +
#'   geom_density_sample(bounds = c(1, Inf), color = 'blue')
#'   
#' @export
geom_density_sample <- make_constructor(
  ggplot2::GeomDensity, stat = "density_sample", times = 10, outline.type = "upper",
  checks = rlang::exprs(
    outline.type <- rlang::arg_match0(outline.type, c("both", "upper", "lower", "full"))
  )
)


