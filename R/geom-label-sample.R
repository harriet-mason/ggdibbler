#' @inheritParams ggplot2::geom_label 
#' @rdname geom_text_sample
#' @importFrom ggplot2 make_constructor GeomLabel
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @export
geom_label_sample <- make_constructor(GeomLabel, position = "nudge", stat = "identity_sample", 
                                      times=10, alpha = 1/log(times), seed = NULL)
