#' @importFrom ggplot2 ggproto StatQqLine
#' @rdname geom_qq_sample
#' @format NULL
#' @usage NULL
#' @export
StatQqLineSample <- ggplot2::ggproto("StatQqLineSample", ggplot2::StatQqLine,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                               extra_params = c("na.rm", "times","seed")
)

#' @rdname geom_qq_sample
#' @importFrom ggplot2 make_constructor
#' @export
geom_qq_line_sample <- make_constructor(StatQqLineSample, geom = "abline", 
                                        omit = "quantiles", times=10, 
                                        alpha = 1/log(times), seed = NULL)

#' @export
#' @rdname geom_qq_sample
stat_qq_line_sample <- geom_qq_line_sample