#' @importFrom ggplot2 ggproto StatDensity
#' @rdname geom_count_sample
#' @format NULL
#' @usage NULL
#' @export
StatDensitySample <- ggproto("StatDensitySample", ggplot2::StatDensity,
                             setup_data = function(data, params) {
                               dibble_to_tibble(data, params)
                             },
                             
                             extra_params = c("na.rm", "times", "bw", "adjust", "kernel",
                                              "n", "trim", "bounds", "flipped_aes", "seed",
                                              "orientation")
                               
)
            
#' @importFrom ggplot2 make_constructor GeomDensity
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @inheritParams ggplot2::geom_density
#' @rdname geom_density_sample
#' @export
stat_density_sample <- make_constructor(
  StatDensitySample, geom = "area", orientation = NA, seed = NULL,
  position = "stack_identity",times=10, alpha = 1/log(times))




  