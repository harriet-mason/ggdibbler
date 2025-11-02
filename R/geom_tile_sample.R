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
