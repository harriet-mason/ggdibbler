#' @importFrom ggplot2 ggproto StatSum
#' @rdname geom_count_sample
#' @format NULL
#' @usage NULL
#' @export
StatSumSample <- ggplot2::ggproto("StatSumSample", ggplot2::StatSum,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params)
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @export
#' @rdname geom_count_sample
#' @inheritParams ggplot2::stat_sum
stat_sum_sample <- make_constructor(StatSumSample, geom = "point", 
                                    times = 10, seed = NULL)


