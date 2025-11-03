#' Rectangles with Uncertainty
#' 
#' Identical to geom_tile and geom_rect, except that they will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_tile
#' @importFrom ggplot2 make_constructor GeomTile
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' library(dplyr)
#' # The most common use for rectangles is to draw a surface. You always want
#' # to use geom_raster here because it's so much faster, and produces
#' # smaller output when saving to PDF
#' ggplot(faithfuld, aes(waiting, eruptions)) + 
#'   geom_raster(aes(fill = density)) #ggplot
#' 
#' # Since raster only plots once, the alpha approach for overplotting does not work
#' # For this reason, we have the default position="dodge" to better see the full sample
#' ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
#'   geom_raster_sample(aes(fill = density)) #ggdibbler
#' 
#' # density 2 is the same as density 1, but with a higher uncertainty
#' ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
#'   geom_raster_sample(aes(fill = density2)) #ggdibbler
#' 
#' # Interpolation smooths the surface & is most helpful when rendering images.
#' # ggplot
#' ggplot(faithfuld, aes(waiting, eruptions)) +
#'   geom_raster(aes(fill = density), interpolate = TRUE)
#' #ggdibbler
#' ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
#'   geom_raster_sample(aes(fill = density), position="dodge", interpolate = TRUE)
#' #ggdibbler
#' ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
#'   geom_raster_sample(aes(fill = density2), position="dodge", interpolate = TRUE) 
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
#' # zero padding
#' # ggplot
#' ggplot(df, aes(x, y, fill = z)) +
#'   geom_raster(hjust = 0, vjust = 0)
#' # ggdibbler
#' ggplot(uncertain_df, aes(x, y, fill = z)) +
#'   geom_raster_sample(hjust = 0, vjust = 0)
#' 
#' @export
geom_tile_sample <- make_constructor(ggplot2::GeomTile, stat = "identity_sample", times=10)
