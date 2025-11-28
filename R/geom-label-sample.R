#' @rdname geom_text_sample
#' @importFrom ggplot2 make_constructor GeomLabel
#' @export
geom_label_sample <- make_constructor(GeomLabel, position = "nudge", stat = "identity_sample", 
                                      times=10, alpha = 1/log(times), seed = NULL)
