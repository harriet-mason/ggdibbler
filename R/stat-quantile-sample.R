#' @importFrom ggplot2 ggproto StatQuantile
#' @rdname geom_quantile_sample
#' @format NULL
#' @usage NULL
#' @export
StatQuantileSample <- ggplot2::ggproto("StatQuantileSample", ggplot2::StatQuantile,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)


#' @export
#' @rdname geom_quantile_sample
#' @inheritParams ggplot2::stat_quantile
stat_quantile_sample <- make_constructor(StatQuantileSample, geom = "quantile",
                                         seed = NULL,  times = 10,
                                         omit = c("xseq", "lambda"))
