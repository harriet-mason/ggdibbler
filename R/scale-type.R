#' Sets scale for distributions
#' 
#' Generates a single value from the distribution and uses it to set the default ggplot scale. The scale can be changed later in the ggplot by using any scale_* function
#' 
#' @importFrom distributional generate
#' @importFrom ggplot2 scale_type
#' @param x value being scaled
#' @return A character vector of scale types. The scale type is the ggplot scale type of the outcome of the distribution.
#' @exportS3Method ggplot2::scale_type
scale_type.distribution <- function(x) {
  datatype <- scale_type(unlist(generate(x,1)))
  # generate a single value from a distribution and use it's class to set scale
  if("discrete" %in% datatype) return(c("discrete_distribution", datatype))
  if("continuous" %in% datatype) return(c("continuous_distribution", datatype))
}


#' @rdname scales::rescale
#' @importFrom ggplot2 scale_type
#' @exportS3Method scales::rescale
rescale.distribution <- function(x, to, from, ...) {
  x <- unlist(generate(x,100))
  rescale(x)
}
