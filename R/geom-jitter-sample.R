#' Uncertain Jittered Points
#' 
#' Identical to geom_jitter, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' 
#' @inheritParams ggplot2::geom_jitter 
#' @importFrom ggplot2 make_constructor GeomPoint position_jitter layer
#' @importFrom rlang list2
#' @importFrom cli cli_abort
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' 
#' point_data <- data.frame(
#'   random_x = c(dist_uniform(2,3),
#'                dist_normal(3,2), 
#'              dist_exponential(3)),
#'   random_y = c(dist_gamma(2,1),
#'              dist_sample(x = list(rnorm(100, 5, 1))),
#'              dist_exponential(1)),
#'    # have some uncertainty as to which category each value belongs to
#'   random_colour = dist_categorical(prob = list(c(0.8,0.15,0.05),
#'                                                  c(0.25,0.7,0.05),
#'                                                  c(0.25,0,0.75)), 
#'                                      outcomes = list(c("A", "B", "C"))),
#'   deterministic_xy = c(1,2,3),
#'   deterministic_colour = c("A", "B", "C"))
#'   
#' # basic random variables x and y
#' ggplot() + 
#'   geom_jitter_sample(data = point_data, width = 0.1, height=0.1,
#'                      aes(x=deterministic_xy, y=deterministic_xy, colour = random_colour))
#'
#' 
#' @export
geom_jitter_sample <- function(mapping = NULL, data = NULL, stat = "sample", position = "jitter",
                        ..., width = NULL, height = NULL, na.rm = FALSE, times=30,
                        show.legend = NA, inherit.aes = TRUE) {
  if (!missing(width) || !missing(height)) {
    if (!missing(position)) {
      cli_abort(c(
        "Both {.arg position} and {.arg width}/{.arg height} were supplied.",
        "i" = "Choose a single approach to alter the position."
      ))
    }
    
    position <- position_jitter(width = width, height = height)
  }
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomPoint,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      na.rm = na.rm,
      times = times,
      ...
    )
  )
}
