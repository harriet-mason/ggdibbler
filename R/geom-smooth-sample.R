#' Uncertain Smooth
#' 
#' Identical to geom_smooth, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_smooth
#' @importFrom ggplot2 GeomSmooth aes layer
#' @importFrom rlang list2
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' # ggplot
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   geom_smooth()
#' 
#' # ggdibbbler
#' ggplot(uncertain_mpg, aes(displ, hwy)) +
#'   geom_point_sample(alpha=0.5, size=0.2, seed = 22) + 
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1, seed = 22) 
#' 
#' # Smooths are automatically fit to each group (defined by categorical
#' # aesthetics or the group aesthetic) and for each facet.
#' # ggplot
#' ggplot(mpg, aes(displ, hwy, colour = class)) +
#'   geom_point() +
#'   geom_smooth(se = FALSE, method = lm)
#' # ggdibbler
#' ggplot(uncertain_mpg, aes(displ, hwy, colour = class)) +
#'   geom_point_sample(alpha=0.5, size=0.2, seed = 22) +
#'   geom_smooth_sample(linewidth=0.2, alpha=0.1, 
#'     se = FALSE, method = lm, seed = 22)
#' 
#' @export
geom_smooth_sample <- function(mapping = NULL, data = NULL,
                        stat = "smooth_sample", position = "identity",
                        ...,
                        seed = NULL,
                        times = 10,
                        method = NULL,
                        formula = NULL,
                        se = TRUE,
                        na.rm = FALSE,
                        orientation = NA,
                        show.legend = NA,
                        inherit.aes = TRUE) {
  
  params <- rlang::list2(
    seed = seed,
    times = times,
    na.rm = na.rm,
    orientation = orientation,
    se = se,
    ...
  )
  if (identical(stat, "smooth_sample")) {
    params[["method"]] <- method
    params$formula <- formula
  }
  
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomSmooth,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = params
  )
}