#' Uncertain contours of a 2D density estimate
#' 
#' Identical to geom_density_2d() and geom_density_2d_filled, except that it 
#' will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_density_2d
#' @inheritParams ggplot2::geom_curve
#' @inheritParams ggplot2::geom_polygon
#' @importFrom ggplot2 layer GeomDensity2d
#' @importFrom rlang list2
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @returns A ggplot2 layer
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
#' @export
geom_density_2d_sample <- make_constructor(ggplot2::GeomDensity2d, 
                                                  stat = "density_2d_sample",
                                                  times=10, seed = NULL)

#' @export
#' @rdname geom_density_2d_sample
#' @usage NULL
geom_density2d_sample <- geom_density_2d_sample

#' @export
#' @rdname geom_density_2d_sample
geom_density_2d_filled_sample <- make_constructor(ggplot2::GeomDensity2dFilled, 
                                                  stat = "density_2d_filled_sample",
                                                  times=10, seed = NULL)

#' @export
#' @rdname geom_density_2d_sample
#' @usage NULL
geom_density2d_filled_sample <- geom_density_2d_filled_sample
