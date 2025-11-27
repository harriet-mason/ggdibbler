#' @inheritParams ggplot2::geom_raster
#' @importFrom ggplot2 make_constructor GeomRaster
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @export
#' @rdname geom_tile_sample
geom_raster_sample <- make_constructor(ggplot2::GeomRaster, stat = "identity_sample", 
                                        checks = exprs(
                                          ggplot2:::check_number_decimal(hjust), 
                                          ggplot2:::check_number_decimal(vjust)),
                                       times=10, position = "identity_dodge", seed = NULL)