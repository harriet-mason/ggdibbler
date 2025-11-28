#' @inheritParams ggplot2::geom_errorbar
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @importFrom ggplot2 GeomErrorbar make_constructor
#' @rdname geom_linerange_sample
#' @export
geom_errorbar_sample <- make_constructor(ggplot2::GeomErrorbar, times = 10, 
                                         stat = "identity_sample", orientation = NA,
                                         alpha = 1/log(times), seed = NULL)
