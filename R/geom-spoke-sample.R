#' Line segments parameterised by location, direction and distance, with uncertainty
#' 
#' Identical to geom_spoke except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_spoke
#' @importFrom ggplot2 make_constructor GeomSpoke
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' 
#' # deterministic data
#' set.seed(1)
#' df <- expand.grid(x = 1:10, y=1:10)
#' df$angle <- runif(100, 0, 2*pi)
#' df$speed <- runif(100, 0, sqrt(0.1 * df$x))
#' 
#' # uncertain data
#' uncertain_df <- df |>
#'   group_by(x,y) |>
#'   mutate(angle = dist_normal(angle, runif(1,0, 0.5)),
#'          speed = dist_normal(speed, runif(1,0, 0.1))) |>
#'   ungroup()
#' 
#' # ggplot
#' ggplot(df, aes(x, y)) +
#'   geom_point() +
#'   geom_spoke(aes(angle = angle), radius = 0.5)
#' 
#' # ggdibbler
#' ggplot(uncertain_df, aes(x, y)) +
#'   #' can use geom_point or geom_point_sample since x & y are deterministic
#'   geom_point() + #' here we used geom_point
#'   geom_spoke_sample(aes(angle = angle), radius = 0.5, alpha=0.3)
#' 
#' # ggplot
#' ggplot(df, aes(x, y)) +
#'   geom_point() +
#'   geom_spoke(aes(angle = angle, radius = speed))
#' 
#' # ggdibbler
#' ggplot(uncertain_df, aes(x, y)) +
#'   geom_point_sample() + #' and here we used geom_point_sample
#'   geom_spoke_sample(aes(angle = angle, radius = speed), alpha=0.3)
#' @export
geom_spoke_sample <- make_constructor(ggplot2::GeomSpoke, stat = "identity_sample", times=10)
