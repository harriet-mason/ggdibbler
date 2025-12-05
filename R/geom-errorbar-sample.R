#' @importFrom ggplot2 GeomErrorbar make_constructor
#' @rdname geom_linerange_sample
#' @export
geom_errorbar_sample <- make_constructor(ggplot2::GeomErrorbar, times = 10, 
                                         stat = "identity_sample", orientation = NA,
                                        seed = NULL)
