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
#' @returns A ggplot2 layer
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' faithfuld
#' # ggplot2
#' v <- ggplot(faithfuld |>
#'   filter(waiting>80) |>
#'   filter(eruptions >3), 
#'   aes(waiting, eruptions, z = density))
#' v + geom_contour()
#' # ggdibbler
#' u <- ggplot(uncertain_faithfuld |> 
#'   filter(waiting>80) |>
#'   filter(eruptions >3), 
#'   aes(waiting, eruptions, z = density))
#' u + geom_contour_sample() 
#' 
#' # use geom_contour_filled() for filled contours
#' # ggplot2
#' v + geom_contour_filled() # no error (point prediction)
#' # ggdibbler
#' u + geom_contour_filled_sample() 
#' 
#' @export
geom_contour_sample <- make_constructor(ggplot2::GeomContour, 
                                        stat = "contour_sample", 
                                        times=10, seed = NULL,
                                        # Passed to contour stat:
                                        bins = NULL, binwidth = NULL, 
                                        breaks = NULL)


#' @rdname geom_contour_sample
#' @inheritParams ggplot2::geom_contour_filled
#' @importFrom ggplot2 make_constructor GeomContourFilled
#' @export
geom_contour_filled_sample <- make_constructor(
  GeomContourFilled, stat = "contour_filled_sample", 
  times=10, seed = NULL,
  # Passed to contour_filled stat:
  bins = NULL, binwidth = NULL, breaks = NULL
)