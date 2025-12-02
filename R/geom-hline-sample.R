#' @inheritParams ggplot2::geom_hline
#' @importFrom ggplot2 GeomHline aes layer PositionIdentity
#' @importFrom tibble tibble
#' @importFrom rlang list2
#' @export
#' @rdname geom_abline_sample
geom_hline_sample <- function(mapping = NULL, data = NULL,
                       stat = "identity_sample", position = "identity",
                       ...,
                       seed = NULL,
                       times = 10,
                       yintercept,
                       na.rm = FALSE,
                       show.legend = NA,
                       inherit.aes = FALSE) {
  
  # Act like an annotation
  if (!missing(yintercept)) {
    # Warn if supplied mapping and/or data is going to be overwritten
    if (!is.null(mapping)) {
      cli::cli_warn("{.fn geom_hline}: Ignoring {.arg mapping} because {.arg yintercept} was provided.")
    }
    if (!is.null(data)) {
      cli::cli_warn("{.fn geom_hline}: Ignoring {.arg data} because {.arg yintercept} was provided.")
    }
    
    data <- tibble::tibble(yintercept = yintercept)
    mapping <- aes(yintercept = yintercept)
    show.legend <- FALSE
  }
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomHline,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      na.rm = na.rm,
      times = times,
      seed = seed,
      ...
    )
  )
}