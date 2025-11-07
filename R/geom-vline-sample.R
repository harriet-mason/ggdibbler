#' @inheritParams ggplot2::geom_vline
#' @importFrom ggplot2 GeomVline aes layer PositionIdentity
#' @importFrom tibble tibble
#' @importFrom rlang list2
#' @export
#' @rdname geom_abline_sample
geom_vline_sample <- function(mapping = NULL, data = NULL,
                       stat = "identity_sample", position = "identity",
                       ...,
                       times = 10,
                       xintercept,
                       na.rm = FALSE,
                       show.legend = NA,
                       inherit.aes = FALSE) {
  
  # Act like an annotation
  if (!missing(xintercept)) {
    # Warn if supplied mapping and/or data is going to be overwritten
    if (!is.null(mapping)) {
      cli::cli_warn("{.fn geom_vline}: Ignoring {.arg mapping} because {.arg xintercept} was provided.")
    }
    if (!is.null(data)) {
      cli::cli_warn("{.fn geom_vline}: Ignoring {.arg data} because {.arg xintercept} was provided.")
    }
    
    data <- tibble::tibble(xintercept = xintercept)
    mapping <- aes(xintercept = xintercept)
    show.legend <- FALSE
  }
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomVline,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      na.rm = na.rm,
      times = times,
      ...
    )
  )
}