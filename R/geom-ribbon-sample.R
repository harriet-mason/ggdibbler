#' Ribbons and area plots with uncertainty
#' 
#' Identical to geom_ribbon, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_ribbon
#' @importFrom ggplot2 make_constructor GeomRibbon
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(distributional)
#' library(dplyr)
#' library(ggplot2)
#' 
#' # Generate data
#' huron <- data.frame(year = 1875:1972, level = as.vector(LakeHuron))
#' uncertain_huron <- huron |>
#'   group_by(year) |>
#'   mutate(level = dist_normal(level, runif(1,0,2)))
#' 
#' # ggplot
#' h <- ggplot(huron, aes(year))
#' # ggdibbler
#' q <- ggplot(uncertain_huron, aes(year))
#' 
#' # ggplot
#' h + geom_ribbon(aes(ymin=0, ymax=level))
#' # ggdibbler
#' q + geom_ribbon_sample(aes(ymin=0, ymax=level), alpha=0.2)
#' 
#' # ggplot
#' h + geom_area(aes(y = level))
#' # ggdibbler
#' q + geom_area_sample(aes(y = level), alpha=0.2)
#' 
#' # Orientation cannot be deduced by mapping, so must be given explicitly for
#' # flipped orientation
#' # ggplot
#' h + geom_area(aes(x = level, y = year), orientation = "y")
#' # ggdibbler
#' q + geom_area_sample(aes(x = level, y = year), orientation = "y", alpha=0.2)
#' 
#' # Add aesthetic mappings
#' h + #' ggplot
#'   geom_ribbon(aes(ymin = level - 1, ymax = level + 1), fill = "grey70") +
#'   geom_line(aes(y = level))
#' q + #ggdibbler
#'   geom_ribbon_sample(aes(ymin = level - 1, ymax = level + 1), fill = "grey70", alpha=0.2) +
#'   geom_line_sample(aes(y = level), alpha=0.2)
#' 
#' df <- data.frame(
#'   g = c("a", "a", "a", "b", "b", "b"),
#'   x = c(1, 3, 5, 2, 4, 6),
#'   y = c(2, 5, 1, 3, 6, 7)
#' )
#' 
#' uncertain_df <- df |>
#'   mutate(x = dist_normal(x, 0.8),
#'          y = dist_normal(y, 0.8))
#' 
#' # ggplot
#' ggplot(df, aes(x, y, fill = g)) +
#'   geom_area() +
#'   facet_grid(g ~ .)
#' # ggdibbler
#' ggplot(uncertain_df, aes(x, y, fill = g)) +
#'   geom_area_sample(alpha=0.2) +
#'   facet_grid(g ~ .)
#' @export
geom_ribbon_sample <- make_constructor(ggplot2::GeomRibbon, stat = "identity_sample", times=10)


#' @rdname geom_ribbon_sample
#' @importFrom ggplot2 make_constructor GeomRibbon
#' @inheritParams ggplot2::geom_area
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @export
geom_area_sample <- make_constructor(ggplot2::GeomArea, stat = "align_sample", times=10,
                                       orientation = NA, #' position = "stack",
                                      outline.type = "upper",
                                      checks = exprs(
                                        outline.type <- arg_match0(outline.type, c("both", "upper", "lower", "full"))
                                        )
                                      )
