#' @importFrom ggplot2 ggproto StatSmooth
#' @rdname geom_smooth_sample
#' @format NULL
#' @usage NULL
#' @export
StatSmoothSample <- ggplot2::ggproto("StatSmoothSample", ggplot2::StatSmooth,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params)
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @export
#' @rdname geom_smooth_sample
#' @inheritParams ggplot2::stat_smooth
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
stat_smooth_sample <- make_constructor(StatSmoothSample, geom = "smooth", 
                                       times = 10, alpha = 1/log(times), seed = NULL)