#' @importFrom ggplot2 ggproto StatDensity2d
#' @rdname geom_density_2d_sample
#' @format NULL
#' @usage NULL
#' @export
StatDensity2dSample <- ggplot2::ggproto("StatDensity2dSample", ggplot2::StatDensity2d,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @importFrom ggplot2 ggproto StatDensity2d
#' @rdname geom_density_2d_sample
#' @format NULL
#' @usage NULL
#' @export
StatDensity2dFilledSample <- ggplot2::ggproto("StatDensity2dFilledSample", 
                                              ggplot2::StatDensity2dFilled,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "contour",
                                                   "contour_var", "seed")
)

#' @export
#' @rdname geom_density_2d_sample
#' @inheritParams ggplot2::stat_density_2d
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
stat_density_2d_sample <- make_constructor(StatDensity2dSample, geom = "density_2d",
                                           contour = TRUE, contour_var = "density",
                                           times = 10, alpha = 1/log(times), seed = NULL)

#' @export
#' @rdname geom_density_2d_sample
#' @inheritParams ggplot2::stat_density_2d_filled
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
stat_density_2d_filled_sample <- make_constructor(StatDensity2dFilledSample, 
                                                  geom = "density_2d_filled",
                                                  contour = TRUE, contour_var = "density",
                                                  times = 10, alpha = 1/log(times), seed = NULL)