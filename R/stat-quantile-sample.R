#' @importFrom ggplot2 ggproto StatQuantile
#' @rdname geom_quantile_sample
#' @format NULL
#' @usage NULL
#' @export
StatQuantileSample <- ggplot2::ggproto("StatQuantileSample", ggplot2::StatQuantile,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "quantiles",
                                                   "formula", "method", "method.args")
)


#' @export
#' @rdname geom_quantile_sample
#' @inheritParams ggplot2::stat_quantile
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_quantile_sample <- make_constructor(StatQuantileSample, geom = "quantile",
                                        omit = c("xseq", "lambda"), times = 10)
