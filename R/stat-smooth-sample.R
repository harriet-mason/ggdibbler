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
stat_smooth_sample <- make_constructor(StatSmoothSample, geom = "smooth", 
                                       times = 10, seed = NULL)