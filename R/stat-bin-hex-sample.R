#' @importFrom ggplot2 ggproto StatBinhex
#' @rdname geom_hex_sample
#' @format NULL
#' @usage NULL
#' @export
StatBinhexSample <- ggplot2::ggproto("StatBinhexSample", ggplot2::StatBinhex,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @export
#' @rdname geom_hex_sample
#' @inheritParams ggplot2::stat_bin_hex
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_bin_hex_sample <- make_constructor(StatBinhexSample, geom = "hex", 
                                        times = 10, seed = NULL, alpha=0.5/log(times))
