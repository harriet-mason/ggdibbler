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
#' # If you want to draw arbitrary rectangles, use geom_tile_sample() or geom_rect_sample()
#' df <- data.frame(
#'   x = rep(c(2, 5, 7, 9, 12), 2),
#'   y = rep(c(1, 2), each = 5),
#'   z = factor(rep(1:5, each = 2)),
#'   w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
#' )
#' 
#' # ggplot
#' ggplot(df, aes(x, y)) +
#'   geom_tile(aes(fill = z), colour = "grey50")
#' 
#' # Most likely that the positions are deterministic and the colour is random
#' # deterministic x & y, random z
#' uncertain_df2 <- data.frame(
#'   x = rep(c(2, 5, 7, 9, 12), 2),
#'   y = rep(c(1, 2), each = 5),
#'   z = dist_binomial(rep(1:5, each = 2), 0.5),
#'   w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
#' )
#' # plot using geom_tile_sample & geom_tile
#' ggplot(uncertain_df2, aes(x, y, f=z)) +
#'   geom_tile_sample(aes(fill = factor(after_stat(f)+1)), position="dodge") +
#'   geom_tile(fill = NA, colour = "grey50", linewidth=1) +
#'   labs(fill = "z")
#' 
#' # but can also have every variable be random (as usual)
#' 
#' # We are going to represent y as a transformed bernoulli variable
#' # Not entirely necessary, we are just doing this to show you that you can
#' 
#' logic_to_y <- function(x){
#'   as.integer(x) + 1
#' }
#' y_to_logic <- function(x){
#'   rlang::as_logical(x-1)
#' }
#' 
#' uncertain_df <- data.frame(
#'   x = dist_binomial(rep(c(2, 5, 7, 9, 12), 2), 0.9),
#'   y = dist_transformed(dist_bernoulli(0.4*df$y), logic_to_y , y_to_logic),
#'   z = dist_binomial(rep(1:5, each = 2), 0.9),
#'   w = dist_binomial(rep(diff(c(0, 4, 6, 8, 10, 14)), 2), 0.9)
#' )
#' 
#' # ggdibbler
#' ggplot(uncertain_df, aes(x, y)) +
#'   geom_tile_sample(aes(fill = z), colour = "grey50", alpha=0.2) 
#' 
#' # control width with z
#' # ggplot all deterministic variables
#' ggplot(df, aes(x, y, width = w)) +
#'   geom_tile(aes(fill = z), colour = "grey50")
#' # ggdibbler case where only z is random
#' # very very low uncertainty
#' uncertain_df3 <- mutate(uncertain_df2, z =  dist_binomial(rep(1:5, each = 2), 0.99))
#' ggplot(uncertain_df3, aes(x, y, f = z, width = w)) +
#'   geom_tile_sample(aes(fill = as.factor(after_stat(f)+1)), colour = "grey50", alpha=0.2) +
#'   labs(fill = "z")
#' # reasonably high uncertainty
#' ggplot(uncertain_df2, aes(x, y, f = z, width = w)) +
#'   geom_tile_sample(aes(fill = as.factor(after_stat(f)+1)), colour = "grey50", alpha=0.2) +
#'   labs(fill = "z")
#' 
#' # ggdibbler all random variables  (yes, it looks terrible but that's what it looks like, 
#' # why do you even have data like this? what is wrong with you)
#' ggplot(uncertain_df, aes(x, y, f = z, width = w)) +
#'   geom_tile_sample(aes(fill = as.factor(after_stat(f))), colour = "grey50", alpha=0.1)
#' 
#' 
#' rect_df  <- df|>
#'   mutate(xmin = x - w / 2,
#'          xmax = x + w / 2,
#'          ymin = y,
#'          ymax = y + 1)
#' 
#' ggplot(data = rect_df, 
#'        aes(xmin= xmin, xmax = xmax, ymin = ymin, ymax = ymax)) +
#'   geom_rect(aes(fill = z), colour = "grey50")
#' 
#' uncertain_rect  <- uncertain_df2|>
#'   mutate(xmin = x - w / 2,
#'          xmax = x + w / 2,
#'          ymin = y,
#'          ymax = y + 1)
#' 
#' ggplot(data = uncertain_rect, 
#'        aes(xmin= xmin, xmax = xmax, ymin = ymin, ymax = ymax, f = z)) +
#'   geom_rect_sample(aes(fill = as.factor(after_stat(f))), colour = "grey50", alpha=0.2) +
#'   labs(fill = "z")
#' @export
geom_tile_sample <- make_constructor(ggplot2::GeomTile, stat = "identity_sample", times=10)
