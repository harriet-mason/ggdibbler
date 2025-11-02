#' @inheritParams ggplot2::geom_rect
#' @importFrom ggplot2 make_constructor GeomRect
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @export
#' @rdname geom_tile_sample
geom_rect_sample <- make_constructor(ggplot2::GeomRect, stat = "identity_sample", times=10)