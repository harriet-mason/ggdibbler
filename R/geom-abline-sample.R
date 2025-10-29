#' Reference lines with uncertainty: horizontal, vertical, and diagonal 
#' 
#' Identical to geom_vline, geom_hline and geom_abline, except that it will accept a distribution 
#' in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_abline
#' @importFrom ggplot2 GeomAbline aes layer PositionIdentity
#' @importFrom tibble tibble
#' @importFrom rlang list2
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' print("replace me")
#' @export
geom_abline_sample <- function(mapping = NULL, data = NULL,
                               stat = "sample", 
                               times = 10,
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
      ...
    )
  )
}
