#' @rdname geom_text_sample
#' @importFrom ggplot2 make_constructor GeomLabel
#' @importFrom rlang list2
#' @importFrom lifecycle is_present
#' @export
geom_label_sample <- function(mapping = NULL, data = NULL, times = 10, seed = NULL,
                       stat = "identity_sample", position = "nudge",
                       ...,
                       parse = FALSE,
                       label.padding = unit(0.25, "lines"),
                       label.r = unit(0.15, "lines"),
                       label.size = deprecated(),
                       border.colour = NULL,
                       border.color = NULL,
                       text.colour = NULL,
                       text.color = NULL,
                       size.unit = "mm",
                       na.rm = FALSE,
                       show.legend = NA,
                       inherit.aes = TRUE) {
  
  extra_args <- list2(...)
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomLabel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      times = times,
      seed = seed,
      parse = parse,
      label.padding = label.padding,
      label.r = label.r,
      size.unit = size.unit,
      border.colour = border.color %||% border.colour,
      text.colour = text.color %||% text.colour,
      na.rm = na.rm,
      !!!extra_args
    )
  )
}