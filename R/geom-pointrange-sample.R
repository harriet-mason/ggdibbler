#' @importFrom ggplot2 GeomPointrange make_constructor
#' @rdname geom_linerange_sample
#' @export
geom_pointrange_sample <- make_constructor(ggplot2::GeomPointrange, times = 10,
                                           stat = "identity_sample", orientation = NA,
                                           alpha = 1/log(times), seed = NULL)
