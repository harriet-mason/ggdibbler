
#' @export
StatSampleDensity <- ggproto("StatSampleDensity", ggplot2::StatDensity,
                             required_aes = c("x|xdist|y|ydist"),
                             default_aes = aes(x = after_stat(density), 
                                               y = after_stat(density), 
                                               fill = NA, 
                                               weight = 1),
                             
                             dropped_aes = "weight",
                             
                             setup_params = function(self, data, params) {
                               params$flipped_aes <- has_flipped_aes(data, params, main_is_orthogonal = FALSE, main_is_continuous = TRUE)
                               
                               has_x <- !(is.null(data$x) && is.null(params$x))
                               has_xdist <- !(is.null(data$xdist) && is.null(params$xdist))
                               has_y <- !(is.null(data$y) && is.null(params$y))
                               has_y <- !(is.null(data$ydist) && is.null(params$ydist))
                               if (!(has_x|has_xdist) && !(has_y|has_ydist)) {
                                 cli::cli_abort("{.fn {snake_class(self)}} requires an {.field x} or {.field y} aesthetic.")
                               }
                               params
                             },
                               
                             setup_data = function(data, params) {
                               sample_expand(data, params$times)
                               
                             },
                             compute_group = function(self, data, scales, times, bw = "nrd0", adjust = 1, kernel = "gaussian",
                                                      n = 512, trim = FALSE, na.rm = FALSE, bounds = c(-Inf, Inf),
                                                      flipped_aes = FALSE, ...) {
                               print(scales)
                               scales$x <- scale_x_continuous()
                               print(scales)

                               stats <- ggproto_parent(StatDensity, self)$compute_group(data, scales, bw = "nrd0", adjust = 1, kernel = "gaussian",
                                                                               n = 512, trim = trim, na.rm = FALSE, bounds = c(-Inf, Inf),
                                                                               flipped_aes = FALSE, ...)
                               #draws <- split(data, data$drawID)
                               #stats <- lapply(draws, function(draw) {
                               #  ggproto_parent(StatDensity, self)$compute_group(data = draw, scales = scales, bw = bw, adjust = adjust, 
                              #                                                   kernel = kernel, n = n, trim = trim, na.rm = na.rm, bounds = bounds,
                              #                                                   flipped_aes = flipped_aes, ...)
                               
                               }
)
                             
                

#' Visualise Densities with Uncertainty
#' 
#' Identical to geom_sf, except that the fill for each area will be a distribution. 
#' This function will replace the fill area with a grid, where each cell is filled with an outcome from the fill distribution. 
#' 
#' @importFrom ggplot2 aes layer
#' @importFrom rlang list2
#' @param times A parameter used to control the number of samples
#' @returns A ggplot2 geom representing a density sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_density
#' @export
stat_sample_density <- function(mapping = NULL, data = NULL, geom = "density",
                                position = "stack", ..., na.rm = FALSE, 
                                show.legend = NA, inherit.aes = TRUE, times = 30) {
    ggplot2::layer(
      stat = StatSampleDensity, 
      data = data, 
      mapping = mapping, 
      geom = geom, 
      position = position, 
      show.legend = show.legend, 
      inherit.aes = inherit.aes, 
      params = list(times = times, ...)
    )
}
  