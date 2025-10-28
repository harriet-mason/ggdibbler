#' @rdname geom_bar_sample
#' @importFrom ggplot2 make_constructor GeomCol
#' @export
geom_col_sample <- make_constructor(GeomCol, stat = "sample",  
                                    position = "dodge", # was removed (might be bad)
                                    just = 0.5, times = 10
                                    )
