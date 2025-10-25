#' @importFrom ggplot2 ggproto StatSum
#' @rdname geom_count_sample
#' @format NULL
#' @usage NULL
#' @export
StatSumSample <- ggplot2::ggproto("StatSumSample", ggplot2::StatSum,
                         setup_data = function(data, params) {
                           sample_expand(data, params$times) 
                           },
                         
                         compute_panel = function(self, data, scales, times) {
                           ggproto_parent(StatSum, self)$compute_panel(data, scales)
                         }
                             
)

#' @export
#' @rdname geom_count_sample
#' @inheritParams ggplot2::stat_sum
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
stat_sum_sample <- make_constructor(StatSumSample, geom = "point", times = 10)





