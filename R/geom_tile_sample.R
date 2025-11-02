#' Rectangles with Uncertainty
#' 
#' Identical to geom_tile and geom_rect, except that they will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_tile
#' @importFrom ggplot2 make_constructor GeomTile
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' print("replace me")
#' @export
geom_tile_sample <- make_constructor(ggplot2::GeomTile, stat = "identity_sample", times=10,
                                     position = "identity_subdivide")


#' @inheritParams ggplot2::geom_rect
#' @importFrom ggplot2 make_constructor GeomRect
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @export
#' @rdname geom_tile_sample
geom_rect_sample <- make_constructor(ggplot2::GeomRect, stat = "identity_sample", times=10,
                                     position = "identity_subdivide")


#' @inheritParams ggplot2::geom_raster
#' @importFrom ggplot2 make_constructor GeomRaster
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @export
#' @rdname geom_tile_sample
geom_raster_sample <- make_constructor(
  ggplot2::GeomRaster, stat = "identity_sample", times=10,
  checks = exprs(
    check_number_decimal(hjust), 
    check_number_decimal(vjust))
  )