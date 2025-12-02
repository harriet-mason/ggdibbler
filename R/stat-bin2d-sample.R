#' @importFrom ggplot2 ggproto StatBin2d
#' @rdname geom_bin_2d_sample
#' @format NULL
#' @usage NULL
#' @export
StatBin2dSample <- ggplot2::ggproto("StatBin2dSample", ggplot2::StatBin2d,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @export
#' @rdname geom_bin_2d_sample
#' @inheritParams ggplot2::stat_bin_2d
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_bin_2d_sample <- make_constructor(StatBin2dSample, geom = "tile", times = 10,
                                       position="identity_dodge", seed = NULL)




