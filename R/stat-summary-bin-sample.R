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
                                        
                                        extra_params = c("na.rm", "times", "fun.data", 
                                                         "bins", "fun", "fun.min", 
                                                         "fun.max", "binwidth", "breaks",
                                                         "fun.args", "orientation", "show.legend",
                                                         "inherit.aes", "seed")
)

#' @rdname stat_summary_sample
#' @inheritParams ggplot2::stat_summary_bin
#' @importFrom ggplot2 make_constructor
#' @export
stat_summary_bin_sample <- make_constructor(StatSummaryBinSample, geom = "pointrange",
                                            times = 10, alpha = 1/log(times), seed = NULL)

