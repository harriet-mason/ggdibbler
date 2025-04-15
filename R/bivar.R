# Constructor for Bivariate vctrs class
new_bivariate <- function(x=data.frame()) {
  if (!is.data.frame(x)) {
    rlang::abort("`x` must be a data.frame.")
  }
  vctrs::new_rcrd(x, class = "ggdibbler_bivariate")
}


#' `bivariate` vector
#'
#' This creates a bivariate variable that allows us to represent
#' the mean and variance of a distribution as a single variable.
#' @param x
#'  * For `percent()`: a distribution from the `distributional` package
#'  * For `is_percent()`: An object to test.
#' @return An S3 vector of class `ggdibbler_bivariate`.
#' @export
#' @examples
#' bivariate(toy_temp_dist$temp_dist)
bivariate <- function(x=new_dist()) {
  if (!distributional::is_distribution(x)) {
    rlang::abort("`x` must be a distribution vector.")
  }
  # Convert distribution to mean/variance data frame
  x <- data.frame(
    est_mean = distributional:::mean.distribution(x),
    std_err = distributional::variance(x)
  )
  new_bivariate(x)
}


#' @export
#' @rdname bivariate
is_bivariate <- function(x) {
  inherits(x, "ggdibbler_bivariate")
}

#' @export
format.ggdibbler_bivariate <- function(x, ...) {
  out <- lapply(vec_data(x), function(x) {
    return(signif(x, 2))
  })
  out <- lapply(out, format)
  out <- paste0("[", do.call(paste, c(out, sep = ",")), "]")
  out[is.na(x)] <- NA
  out
}

#' @export
vec_ptype_abbr.ggdibbler_bivariate <- function(x, ...) {
  "bivar"
}

#' @export
vec_ptype2.ggdibbler_bivariate.ggdibbler_bivariate <- function(x, y, ...) new_bivariate()

#' @export
vec_ptype2.ggdibbler_bivariate.data.frame <- function(x, y, ...) data.frame()

#' @export
vec_ptype2.data.frame.ggdibbler_bivariate <- function(x, y, ...) data.frame()

#' @export
vec_cast.ggdibbler_bivariate.ggdibbler_bivariate <- function(x, to, ...) x

#' @export
vec_cast.ggdibbler_bivariate.data.frame <- function(x, to, ...) bivariate(x)

#' @export
vec_cast.data.frame.ggdibbler_bivariate <- function(x, to, ...) data.frame(vec_data(x))

#' @export
vec_cast.ggdibbler_bivariate.distribution <- function(x, to, ...) bivariate(x)

#' @export
vec_cast.distribution.ggdibbler_bivariate <- function(x, to, ...) distributional::dist_normal(x)

#' @export
as_bivariate <- function(x) {
  vec_cast(x, new_bivariate())
}
