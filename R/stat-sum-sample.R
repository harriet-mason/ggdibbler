#' @importFrom ggplot2 ggproto StatSum
#' @importFrom rlang !!!
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


map_func <- function(new, old) {
  if (empty(new)) return(data_frame0())
  # First, filter out the columns already included `new` (type 1).
  old <- old[, !(names(old) %in% names(new)), drop = FALSE]
  vctrs::vec_cbind(new, old[rep(1, nrow(new)), , drop = FALSE])
}




