#' @inheritParams ggplot2::geom_curve
#' @importFrom ggplot2 make_constructor GeomCurve
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @export
#' @rdname geom_segment_sample
geom_curve_sample <- make_constructor(ggplot2::GeomCurve, stat = "identity_sample", 
                                      times=10, alpha = 1/log(times), seed = NULL)