#' Sets default scale for distribution objects
#' Default scale for distribution objects is continuous
#'
#' @param x variable being scaled
#'
#' @exportS3Method ggplot2::scale_type
scale_type.distribution <- function(x) {
  "continuous"
}