#' Uncertain 2D contours of a 3D surface
#' 
#' Identical to geom_contour and geom_contour_filled, except that it will 
#' accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_contour
#' @importFrom ggplot2 make_constructor GeomContour
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @examples
#' library(ggplot2)
#' 
#' # ggplot2
#' v <- ggplot(faithfuld, aes(waiting, eruptions, z = density))
#' v + geom_contour()
#' 
#' # ggdibbler
#' u0 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions, z = density0))
#' u1 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions, z = density))
#' u2 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions, z = density2))
#' # plot them
#' u0 + geom_contour_sample() # low noise
#' u1 + geom_contour_sample() # mod noise
#' u2 + geom_contour_sample() # high noise
#' 
#' # use geom_contour_filled() for filled contours
#' # ggplot2
#' v + geom_contour_filled() # no error (point prediction)
#' # ggdibbler
#' u0 + geom_contour_filled_sample() # low se
#' u1 + geom_contour_filled_sample() # med se
#' u2 + geom_contour_filled_sample() # high se
#' 
#' @export
geom_contour_sample <- make_constructor(ggplot2::GeomContour, 
                                        stat = "contour_sample", times=10,
                                        alpha = 0.5/log(times), seed = NULL,
                                        # Passed to contour stat:
                                        bins = NULL, binwidth = NULL, 
                                        breaks = NULL)


#' @rdname geom_contour_sample
#' @inheritParams ggplot2::geom_contour_filled
#' @importFrom ggplot2 make_constructor GeomContourFilled
#' @export
geom_contour_filled_sample <- make_constructor(
  GeomContourFilled, stat = "contour_filled_sample", times=10,
  alpha = 0.5/log(times), seed = NULL,
  # Passed to contour_filled stat:
  bins = NULL, binwidth = NULL, breaks = NULL
)