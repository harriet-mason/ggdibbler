#' @importFrom ggplot2 ggproto StatSummaryHex
#' @rdname stat_summary_2d_sample
#' @format NULL
#' @usage NULL
#' @export
StatSummaryHexSample <- ggplot2::ggproto("StatSummaryHexSample", ggplot2::StatSummaryHex,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @rdname stat_summary_2d_sample
#' @inheritParams ggplot2::stat_summary_hex
#' @importFrom ggplot2 make_constructor
#' @export
stat_summary_hex_sample <- make_constructor(StatSummaryHexSample, geom = "hex", 
                                    times = 10, alpha = 1/log(times), seed = NULL)
