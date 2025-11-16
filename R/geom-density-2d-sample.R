#' Uncertain contours of a 2D density estimate
#' 
#' Identical to geom_density_2d() and geom_density_2d_filled, except that it 
#' will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_density_2d
#' @importFrom ggplot2 layer GeomDensity2d
#' @importFrom rlang list2
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' # ggplot
#' m <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
#'   geom_point() +
#'   xlim(0.5, 6) +
#'   ylim(40, 110)
#' # contour lines
#' m + geom_density_2d()
#' 
#' # ggdibbler
#' n <- ggplot(uncertain_faithful, aes(x = eruptions, y = waiting)) +
#'   geom_point_sample(size=2/10) +
#'   scale_x_continuous_distribution(limits = c(0.5, 6)) +
#'   scale_y_continuous_distribution(limits = c(40, 110))
#' n + geom_density_2d_sample(linewidth=2/10, alpha=0.5)
#' 
#' # contour bands
#' # ggplot
#' m + geom_density_2d_filled(alpha = 0.5)
#' # ggdibbler
#' n + geom_density_2d_filled_sample(alpha = 0.1)
#' 
#' 
#' # contour bands and contour lines
#' # ggplot
#' m + geom_density_2d_filled(alpha = 0.5) +
#'   geom_density_2d(linewidth = 0.25, colour = "black")
#' # ggdibbler
#' n + geom_density_2d_filled_sample(alpha = 0.1) +
#'   geom_density_2d_sample(linewidth = 0.2, colour = "black", alpha=0.5)
#' 
#' # If we turn contouring off, we can use other geoms
#' d + stat_density_2d(geom = "point", aes(size = after_stat(density)), n = 20, contour = FALSE)
#' b + stat_density_2d_sample(geom = "point", alpha = 0.15,
#'                            aes(size = after_stat(density)), n = 20, contour = FALSE)
#' @export
geom_density_2d_sample <- function(mapping = NULL, data = NULL,
                                   stat = "density_2d_sample", 
                                   position = "identity",
                                   ...,
                                   times = 10,
                                   contour_var = "density",
                                   lineend = "butt",
                                   linejoin = "round",
                                   linemitre = 10,
                                   na.rm = FALSE,
                                   show.legend = NA,
                                   inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomDensity2d,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(
      times = times,
      lineend = lineend,
      linejoin = linejoin,
      linemitre = linemitre,
      contour = TRUE,
      contour_var = contour_var,
      na.rm = na.rm,
      ...
    )
  )
}

#' @export
#' @rdname geom_density_2d_sample
#' @usage NULL
geom_density2d_sample <- geom_density_2d_sample

#' @export
#' @rdname geom_density_2d_sample
geom_density_2d_filled_sample <- function(mapping = NULL, data = NULL,
                                   stat = "density_2d_filled_sample", 
                                   position = "identity",
                                   ...,
                                   times = 10,
                                   contour_var = "density",
                                   na.rm = FALSE,
                                   show.legend = NA,
                                   inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggplot2::GeomDensity2dFilled,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(
      times = times,
      na.rm = na.rm,
      contour = TRUE,
      contour_var = contour_var,
      ...
    )
  )
}

#' @export
#' @rdname geom_density_2d_sample
#' @usage NULL
geom_density2d_filled_sample <- geom_density_2d_filled_sample
