#' Reference lines with uncertainty: horizontal, vertical, and diagonal 
#' 
#' Identical to geom_vline, geom_hline and geom_abline, except that it will accept a distribution 
#' in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_abline
#' @importFrom ggplot2 GeomAbline aes layer PositionIdentity
#' @importFrom tibble tibble
#' @importFrom rlang list2
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @returns A ggplot2 layer
#' @examples
#' # load libraries
#' library(ggplot2)
#' library(distributional)
#' 
#' # ggplot
#' p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
#' # ggdibbler
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg)) + geom_point_sample(alpha=0.3)
#' 
#' # ggplot
#' p + geom_abline(intercept = 20) # ggplot
#' q + geom_abline_sample(intercept = dist_normal(20, 1), alpha=0.3) # ggdibbler
#' p + geom_vline(xintercept = 5) # ggplot
#' q + geom_vline_sample(xintercept = dist_normal(5, 0.1), alpha=0.3) # ggdibbler
#' p + geom_hline(yintercept = 20) # ggplot
#' q + geom_hline_sample(yintercept = dist_normal(20, 1), alpha=0.3) # ggdibbler 
#' 
#' # Calculate slope and intercept of line of best fit
#' # get coef and standard error
#' summary(lm(mpg ~ wt, data = mtcars))
#' # ggplot for coef
#' p + geom_abline(intercept = 37, slope = -5) # ggplot
#' # ggdibbler for coef AND standard error
#' p + geom_abline_sample(intercept = dist_normal(37, 1.8), 
#'   slope = dist_normal(-5, 0.56),
#'   times=30, alpha=0.3) # ggplot
#' @export
geom_abline_sample <- function(mapping = NULL, data = NULL,
                               stat = "identity_sample", 
                               times = 10,
                               seed = NULL,
                               ...,
                               slope,
                               intercept,
                               na.rm = FALSE,
                               show.legend = NA,
                               inherit.aes = FALSE) {
  
  # If nothing set, default to y = x
  if (is.null(mapping) && missing(slope) && missing(intercept)) {
    slope <- 1
    intercept <- 0
  }
  
  # Act like an annotation
  if (!missing(slope) || !missing(intercept)) {
    
    # Warn if supplied mapping and/or data is going to be overwritten
    if (!is.null(mapping)) {
      cli::cli_warn("{.fn geom_abline}: Ignoring {.arg mapping} because {.arg slope} and/or {.arg intercept} were provided.")
    }
    if (!is.null(data)) {
      cli::cli_warn("{.fn geom_abline}: Ignoring {.arg data} because {.arg slope} and/or {.arg intercept} were provided.")
    }
    
    if (missing(slope)) slope <- 1
    if (missing(intercept)) intercept <- 0
    n_slopes <- max(length(slope), length(intercept))
    
    data <- tibble::tibble(
      intercept = intercept,
      slope = slope,
      .size = n_slopes
    )
    mapping <- ggplot2::aes(intercept = intercept, slope = slope)
    show.legend <- FALSE
  }
  
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomAbline,
    position = ggplot2::PositionIdentity,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(
      na.rm = na.rm,
      times = times,
      seed = seed,
      ...
    )
  )
}
