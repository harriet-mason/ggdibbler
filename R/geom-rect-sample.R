#' @importFrom ggplot2 make_constructor GeomRect
#' @export
#' @rdname geom_tile_sample
geom_rect_sample <- make_constructor(ggplot2::GeomRect, stat = "identity_sample", 
                                     times=10, seed = NULL)