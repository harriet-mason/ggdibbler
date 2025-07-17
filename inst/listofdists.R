# Continuous dist
dcontinuous <- c("burr", "beta", "cauchy", "chisq", "exponential", "f", 
                 "gamma", "gev", "gh", "gk", "gpd", "gumbel", "hypergeometric", 
                 "inverse_exponential", "inverse_gamma", "inverse_gaussian", "logistic",
                 "lognormal", "mvnorm", "normal", "pareto", "student_t", "studentized_range",
                 "uniform", "weibull")
# Discrete
ddiscrete <- c("binomial", "geometric", "logarithmic", "multinomial", "negbin", "poisson",
               "poisson_inverse_gaussian")
# Categorial
dcategorical <- c("bernoulli", "categorical")

# Other
dother <- c("degenerate", "percentile", "sample")

# if scale_type cant be used inside scale_type.distribution 
class(unlist(distributional::generate(x,1)))

#' Sets default scale for distribution objects
#' 
#' @param x variable being scaled
#' @exportS3Method ggplot2::scale_type
#' @export
scale_type.distribution <- function(x) {
  "continuous"
}

#' Sets default scale for distribution objects
#' Default scale for distribution objects is continuous
#'
#' @param x variable being scaled
#'
#' @exportS3Method ggplot2::scale_type
scale_type.distribution <- function(x) {
  "continuous"
}

