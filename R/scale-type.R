#' Sets scale for distributions
#' 
#' Generates a single value from the distribution and uses it to set the default ggplot scale. The scale can be changed later in the ggplot by using any scale_* function
#' 
#' @importFrom distributional generate
#' @importFrom ggplot2 scale_type
#' @param x value being scaled
#' @return A character vector of scale types. The scale type is the ggplot scale type of the outcome of the distribution.
#' 
#' @exportS3Method ggplot2::scale_type
scale_type.distribution <- function(x) {
  # generate a single value from a distribution and use it's class to set scale
  scale_type(unlist(distributional::generate(x,1))) #breaks position scale
   # "identity"
}