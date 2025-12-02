#' @importFrom ggplot2 make_constructor GeomRaster
#' @export
#' @rdname geom_tile_sample
geom_raster_sample <- make_constructor(ggplot2::GeomRaster, stat = "identity_sample", 
                                       times=10, position = "identity_dodge", seed = NULL)