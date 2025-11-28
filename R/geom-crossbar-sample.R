#' @inheritParams ggplot2::geom_crossbar
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @importFrom ggplot2 GeomCrossbar make_constructor
#' @importFrom rlang list2
#' @rdname geom_linerange_sample
#' @export
geom_crossbar_sample <- make_constructor(ggplot2::GeomCrossbar, 
                                         stat = "identity_sample", 
                                         times=10, orientation = NA, 
                                         alpha = 0.5/log(times), 
                                         seed = NULL)

