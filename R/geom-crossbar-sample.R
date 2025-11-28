#' @importFrom ggplot2 GeomCrossbar make_constructor
#' @importFrom rlang list2
#' @rdname geom_linerange_sample
#' @export
geom_crossbar_sample <- make_constructor(ggplot2::GeomCrossbar, 
                                         stat = "identity_sample", 
                                         times=10, orientation = NA, 
                                         alpha = 0.5/log(times), 
                                         seed = NULL)

