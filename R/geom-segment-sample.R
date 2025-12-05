#' Line segments and curves with uncertainty
#' 
#' Identical to geom_segment, except that it will accept a distribution in 
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_segment
#' @inheritParams ggplot2::geom_curve
#' @importFrom ggplot2 make_constructor GeomSegment
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @returns A ggplot2 layer
#' 
#' @examples
#' library(ggplot2)
#' library(distributional)
#' # ggplot
#' b <- ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point()
#' # ggdibbler
#' a <- ggplot(uncertain_mtcars, aes(wt, mpg)) +
#'   geom_point_sample(seed=77, alpha=0.5)
#' 
#' 
#' df <- data.frame(x1 = 2.62, x2 = 3.57, 
#'                  y1 = 21.0, y2 = 15.0)
#' uncertain_df <- data.frame(x1 = dist_normal(2.62, 0.1), 
#'                            x2 = dist_normal(3.57,0.1), 
#'                            y1 = dist_normal(21.0, 0.1), 
#'                            y2 = dist_normal(15.0,0.1))
#' # ggplot
#' b +
#'   geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "curve"), data = df) +
#'   geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "segment"), data = df)
#' 
#' # ggdibbler
#' a +
#'   geom_curve_sample(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "curve"), 
#'                     data = uncertain_df, seed=77, alpha=0.5) +
#'   geom_segment_sample(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "segment"), 
#'                       data = uncertain_df, seed=77, alpha=0.5)
#'                       
#' @export
geom_segment_sample <- make_constructor(ggplot2::GeomSegment, stat = "identity_sample", 
                                        times=10, seed = NULL)
