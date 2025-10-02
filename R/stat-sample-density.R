
#' @export
StatSampleDensity <- ggproto("StatSampleDensity", ggplot2::StatDensity,
                             setup_params = function(self, data, params) {
                               params$flipped_aes <- has_flipped_aes(data, params, main_is_orthogonal = FALSE, main_is_continuous = TRUE)
                               has_x <- !(is.null(data$x) && is.null(params$x))
                               has_xdist <- !(is.null(data$xdist) && is.null(params$xdist))
                               has_y <- !(is.null(data$y) && is.null(params$y))
                               has_ydist <- !(is.null(data$ydist) && is.null(params$ydist))
                               if (!(has_x|has_xdist) && !(has_y|has_ydist)) {
                                 cli::cli_abort("{.fn {snake_class(self)}} requires an {.field x} or {.field y} aesthetic.")
                               }
                               
                               params
                             },
                             extra_params = c("na.rm", "orientation", "times"),
                             
                             compute_layer = function(self, data, params, layout) {
                               print(params)
                               print(data)
                               data <- sample_expand(data, params$times) 
                                #select(-distID)
                               print(ggproto_parent(StatDensity, self)$compute_layer)
                               ggproto_parent(StatDensity, self)$compute_layer(self, data, params, layout)
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
stat_sample_density <- function(mapping = NULL, data = NULL, geom = "area",
                                position = "stack", ..., na.rm = FALSE, 
                                show.legend = NA, inherit.aes = TRUE, times = 10) {
  capture_and_filter_warnings({
    ggplot2::layer(
      stat = StatSampleDensity, 
      data = data, 
      mapping = mappingswap(mapping, data), #swap mapping to avoid scale problem
      geom = geom, 
      position = position, 
      show.legend = show.legend, 
      inherit.aes = inherit.aes, 
      params = list(times = times, ...)
    )
  })
}
  