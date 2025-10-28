#' @importFrom ggplot2 ggproto StatDensity
#' @rdname geom_count_sample
#' @format NULL
#' @usage NULL
#' @export
StatDensitySample <- ggproto("StatDensitySample", ggplot2::StatDensity,
 
                             setup_data = function(data, params) {
                               sample_expand(data, params$times)
                               },
                             
                             extra_params = c("na.rm", "times", "bw", "adjust", "kernel",
                                              "n", "trim", "bounds", "flipped_aes")
                               
)
            
#' @importFrom ggplot2 make_constructor GeomDensity
#' @param times A parameter used to control the number of samples
#' @inheritParams ggplot2::geom_density
#' @rdname geom_density_sample
#' @export
stat_density_sample <- make_constructor(
  ggplot2::GeomDensity, stat = "density_sample", times=10
)




  