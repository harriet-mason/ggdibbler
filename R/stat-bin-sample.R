#' @importFrom ggplot2 ggproto StatBin
#' @rdname geom_histogram_sample
#' @format NULL
#' @usage NULL
#' @export
StatBinSample <- ggplot2::ggproto("StatBinSample", ggplot2::StatBin,
                                  setup_params = function(self, data, params) {
                                    times <- params$times
                                    params$times <- 1
                                    data <- dibble_to_tibble(data, params)
                                    params <- ggplot2::ggproto_parent(ggplot2::StatBin, self)$setup_params(data, params)
                                    params$times <- times
                                    params
                                  },
                                  
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "show.legend", "inherit.aes",
                                                   "binwidth", "bins", "orientation", "lineend,",
                                                   "linejoin", "center", "boundary", "closed", "pad", 
                                                   "breaks", "drop")
)

#' @export
#' @rdname geom_histogram_sample
#' @inheritParams ggplot2::stat_bin
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_bin_sample <- make_constructor(StatBinSample, geom = "bar", times = 10, #position = "stack",
                                    orientation = NA)
