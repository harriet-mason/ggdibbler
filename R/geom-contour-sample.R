#' Uncertain 2D contours of a 3D surface
#' 
#' Identical to geom_contour and geom_contour_filled, except that it will 
#' accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_contour
#' @importFrom ggplot2 make_constructor GeomContour
#' @param times A parameter used to control the number of values sampled 
#' from each distribution.
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
#' u0 + geom_contour_sample(alpha=0.2) # low noise
#' u1 + geom_contour_sample(alpha=0.2) # mod noise
#' u2 + geom_contour_sample(alpha=0.2) # high noise
#' 
#' # use geom_contour_filled() for filled contours
#' # ggplot2
#' v + geom_contour_filled() # no error (point prediction)
#' # ggdibbler
#' u0 + geom_contour_filled_sample(alpha=0.1) # low se
#' u1 + geom_contour_filled_sample(alpha=0.1) # med se
#' u2 + geom_contour_filled_sample(alpha=0.1) # high se
#' 
#' # Other parameters
#' v + geom_raster(aes(fill = density)) +
#'   geom_contour(colour = "white")
#' u + geom_raster_sample(aes(fill = density)) +
#'   geom_contour_sample(colour = "white", alpha=0.1)
#' @export
geom_contour_sample <- make_constructor(ggplot2::GeomContour, 
                                        stat = "contour_sample", times=10,
                                        # Passed to contour stat:
                                        bins = NULL, binwidth = NULL, 
                                        breaks = NULL)


#' @rdname geom_contour_sample
#' @inheritParams ggplot2::geom_contour_filled
#' @importFrom ggplot2 make_constructor GeomContourFilled
#' @export
geom_contour_filled_sample <- make_constructor(
  GeomContourFilled, stat = "contour_filled_sample", times=10,
  # Passed to contour_filled stat:
  bins = NULL, binwidth = NULL, breaks = NULL
)