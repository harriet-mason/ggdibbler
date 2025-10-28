#' @inheritParams ggplot2::geom_label 
#' @rdname geom_text_sample
#' @importFrom ggplot2 make_constructor GeomLabel
#' @param times A parameter used to control the number of values sampled from each distribution. 
#' @export
geom_label_sample <- make_constructor(GeomLabel, position = "nudge", stat = "sample", times=10)
