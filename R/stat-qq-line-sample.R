#' @importFrom ggplot2 ggproto StatQqLine
#' @rdname geom_qq_sample
#' @format NULL
#' @usage NULL
#' @export
StatQqLineSample <- ggplot2::ggproto("StatQqLineSample", ggplot2::StatQqLine,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                               extra_params = c("na.rm", "times", "distribution", 
                                                "dparams", "line.p", "fullrange",
                                                "seed")
)

#' @rdname geom_qq_sample
#' @inheritParams ggplot2::geom_qq_line
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @export
geom_qq_line_sample <- make_constructor(StatQqLineSample, geom = "abline", 
                                        omit = "quantiles", times=10, 
                                        alpha = 1/log(times), seed = NULL)

#' @export
#' @rdname geom_qq_sample
stat_qq_line_sample <- geom_qq_line_sample