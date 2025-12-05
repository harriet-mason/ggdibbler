#' @importFrom ggplot2 ggproto StatSummaryBin
#' @rdname stat_summary_sample
#' @format NULL
#' @usage NULL
#' @export
StatSummaryBinSample <- ggplot2::ggproto("StatSummaryBinSample", ggplot2::StatSummaryBin,
                                         setup_params = function(self, data, params) {
                                           times <- params$times
                                           params$times <- 1
                                           data <- dibble_to_tibble(data, params)
                                           params <- ggplot2::ggproto_parent(ggplot2::StatSummaryBin, 
                                                                             self)$setup_params(data, params)
                                           params$times <- times
                                           params
                                         },
                                         
                                        setup_data = function(data, params) {
                                          dibble_to_tibble(data, params) 
                                        },
                                        
                                        extra_params = c("na.rm", "times", "seed",
                                                         "orientation", "fun.data", 
                                                         "fun.max", "fun.min", 
                                                         "fun.args")
)

#' @rdname stat_summary_sample
#' @importFrom ggplot2 make_constructor
#' @export
stat_summary_bin_sample <- function(mapping = NULL, data = NULL, 
                             times = 10, seed = NULL,
                             geom = "pointrange", position = "identity",
                             ...,
                             fun.data = NULL,
                             fun = NULL,
                             fun.max = NULL,
                             fun.min = NULL,
                             fun.args = list(),
                             bins = 30,
                             binwidth = NULL,
                             breaks = NULL,
                             na.rm = FALSE,
                             orientation = NA,
                             show.legend = NA,
                             inherit.aes = TRUE,
                             fun.y = deprecated(),
                             fun.ymin = deprecated(),
                             fun.ymax = deprecated()) {
  if (lifecycle::is_present(fun.y)) {
    fun <- fun %||% fun.y
  }
  if (lifecycle::is_present(fun.ymin)) {
    fun.min <- fun.min %||% fun.ymin
  }
  if (lifecycle::is_present(fun.ymax)) {
    fun.max <- fun.max %||% fun.ymax
  }
  layer(
    data = data,
    mapping = mapping,
    stat = StatSummaryBinSample,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      times = times,
      seed = seed,
      fun.data = fun.data,
      fun = fun,
      fun.max = fun.max,
      fun.min = fun.min,
      fun.args = fun.args,
      bins = bins,
      binwidth = binwidth,
      breaks = breaks,
      na.rm = na.rm,
      orientation = orientation,
      ...
    )
  )
}
