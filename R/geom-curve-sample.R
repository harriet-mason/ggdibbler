#' @importFrom ggplot2 make_constructor GeomCurve
#' @export
#' @rdname geom_segment_sample
geom_curve_sample <- make_constructor(ggplot2::GeomCurve, stat = "identity_sample", 
                                      times=10, alpha = 1/log(times), seed = NULL)