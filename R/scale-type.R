#' @export
scale_type <- function(x) UseMethod("scale_type")

#' Sets default scale for distribution objects
#' Default scale for distribution objects is continuous
#' @param x variable being scaled
#' @export
scale_type.distribution <- function(x) {
  "continuous"
}