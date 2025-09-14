#' Transformation for distribution class
#' 
#' This function only exists to stop continuous position scales from returning an error.
#' It isn't (and shouldn't) be used for plotting.
#' @importFrom distributional dist_sample generate
#' @importFrom scales new_transform
#' @export
transform_dist <- function() {
  to_dist <- function(x) {
    newx <- dist_normal(x,1)
    print(newx)
    structure(newx, class = c("distribution", "vctrs_vctr", "list"))
  }
  
  from_dist <- function(x) {
    print(x)
    if (!inherits(x, "distribution")) {
      cli::cli_abort(
        "{.fun transform_dist} works with objects of class {.cls distribution} only"
      )
    }
    newx <- unlist(generate(x,1))
    print(newx)
    structure(newx)
  }
  
  new_transform(
    "dist",
    transform = "from_dist",
    inverse = "to_dist",
    breaks = breaks_extended(), 
    domain = c(-1e100, 1e100)
    )
}

#' @export
#' @rdname transform_dist
dist_trans <- transform_dist

