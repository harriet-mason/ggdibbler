#' Plot rectangles with uncertainty
#' 
#' Identical to geom_tile and geom_rect, except that they will accept a 
#' distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_rect
#' @inheritParams ggplot2::geom_tile
#' @inheritParams ggplot2::geom_raster
#' @importFrom ggplot2 make_constructor GeomTile
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @returns A ggplot2 layer
#' @examples
#' library(ggplot2)
#' library(distributional)
#' library(dplyr)
#' 
#' # Rasters
#' #ggplot
#' ggplot(faithfuld, aes(waiting, eruptions)) + 
#'   geom_raster(aes(fill = density)) 
#' #ggdibbler
#' ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
#'   geom_raster_sample(aes(fill = density)) 
#' 
#' # Justification controls where the cells are anchored
#' df <- expand.grid(x = 0:5, y = 0:5)
#' set.seed(1)
#' df$z <- runif(nrow(df))
#' uncertain_df <- df |> 
#'   group_by(x,y) |>
#'   mutate(z = dist_normal(z, runif(1, 0, 0.1))) |>
#'   ungroup()
#' 
#' # default is compatible with geom_tile()
#' # ggplot
#' ggplot(df, aes(x, y, fill = z)) +
#'   geom_raster()
#' #ggdibbler
#' ggplot(uncertain_df, aes(x, y, fill = z)) +
#'   geom_raster_sample()
#' 
#' # If you want to draw arbitrary rectangles, 
#' # use geom_tile_sample() or geom_rect_sample()
#' tile_df <- data.frame(
#'   x = rep(c(2, 5, 7, 9, 12), 2),
#'   y = rep(c(1, 2), each = 5),
#'   z = factor(rep(1:5, each = 2)),
#'   w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
#' )
#' # most likely case that only colour is random
#' uncertain_tile_df <- tile_df
#' uncertain_tile_df$z <- dist_transformed((1 + dist_binomial(rep(1:5, 
#'   each = 2), 0.5)), factor, as.numeric)
#' 
#' # ggplot
#' ggplot(tile_df, aes(x, y)) +
#'   geom_tile(aes(fill = z), colour = "grey50")
#' # ggdibbler
#' ggplot(uncertain_tile_df, aes(x, y)) +
#'   geom_tile_sample(aes(fill = z), position="identity_dodge") +
#'   geom_tile(fill = NA, colour = "grey50", linewidth=1) +
#'   labs(fill = "z")
#' 
#' # Rectangles
#' rect_df  <- tile_df |>
#'   mutate(xmin = x - w / 2,
#'          xmax = x + w / 2,
#'          ymin = y,
#'          ymax = y + 1)
#'          
#' uncertain_rect  <- rect_df|>
#'   mutate(xmin = dist_normal(xmin, 0.5),
#'          xmax = dist_normal(xmax, 0.5),
#'          ymin = dist_normal(ymin, 0.5),
#'          ymax = dist_normal(ymax, 0.5))
#'          
#' # ggplot
#' ggplot(data = rect_df, 
#'        aes(xmin= xmin, xmax = xmax, ymin = ymin, ymax = ymax)) +
#'   geom_rect(aes(fill = z), colour = "grey50")
#' # ggdibbler
#' ggplot(data = uncertain_rect, 
#'        aes(xmin= xmin, xmax = xmax, ymin = ymin, ymax = ymax, f = z)) +
#'   geom_rect_sample(aes(fill = as.factor(after_stat(f))), 
#'     colour = "grey50", alpha=0.2) +
#'   labs(fill = "z")
#' @export
geom_tile_sample <- make_constructor(ggplot2::GeomTile, 
                                     stat = "identity_sample", 
                                     times=10, seed = NULL, 
                                     position="identity_dodge")
