#' @importFrom ggplot2 ggproto Stat***
#' @rdname geom_smooth_sample
#' @format NULL
#' @usage NULL
#' @export
StatSmoothSample <- ggplot2::ggproto("StatSmoothSample", ggplot2::StatSmooth,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params)
                                  },
                                  
                                  extra_params = c("na.rm", "times", "method", "formula", "se",
                                                   "orientation", "show.legend", "inherit.aes",
                                                   "fullrange", "show.legend", "inherit.aes",
                                                   "n", "span", "xseq", "level", "method.args"
                                                   )
)

#' @export
#' @rdname geom_smooth_sample
#' @inheritParams ggplot2::stat_smooth
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
stat_smooth_sample <- make_constructor(StatSmoothSample, geom = "smooth", times = 10)