#' Uncertain Polygons
#' 
#' Identical to geom_polygon, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_polygon
#' @importFrom ggplot2 make_constructor GeomPolygon
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' # When using geom_polygon, you will typically need two data frames:
#' # one contains the coordinates of each polygon (positions),  and the
#' # other the values associated with each polygon (values).  An id
#' # variable links the two together
#' library(distributional)
#' library(ggplot2)
#' library(dplyr)
#' ids <- factor(c("1.1", "2.1", "1.2", "2.2", "1.3", "2.3"))
#' values <- data.frame(
#'   id = ids,
#'   value = c(3, 3.1, 3.1, 3.2, 3.15, 3.5)
#' )
#' positions <- data.frame(
#'   id = rep(ids, each = 4),
#'   x = c(2, 1, 1.1, 2.2, 1, 0, 0.3, 1.1, 2.2, 1.1, 1.2, 2.5, 1.1, 0.3,
#'         0.5, 1.2, 2.5, 1.2, 1.3, 2.7, 1.2, 0.5, 0.6, 1.3),
#'   y = c(-0.5, 0, 1, 0.5, 0, 0.5, 1.5, 1, 0.5, 1, 2.1, 1.7, 1, 1.5,
#'         2.2, 2.1, 1.7, 2.1, 3.2, 2.8, 2.1, 2.2, 3.3, 3.2)
#' )
#' # Currently we need to manually merge the two together
#' # ggplot
#' datapoly <- merge(values, positions, by = c("id"))
#' # ggdibbler
#' uncertain_datapoly <- datapoly |>
#'   mutate(x = dist_uniform(x-0.1, x + 0.1),
#'          y = dist_uniform(y-0.1, y + 0.1),
#'          value = dist_uniform(value-0.1, value + 0.1))
#' 
#' # Smaller working example
#' single_data <- datapoly |> filter(id %in% c("1.1", "1.2"))
#' single_uncertain_data <- uncertain_datapoly |> filter(id %in% c("1.1", "1.2"))
#' # ggplot
#' ggplot(single_data, aes(x = x, y = y)) +
#'   geom_polygon(aes(group = id, fill=value))
#' # ggdibbler
#' ggplot(single_uncertain_data, aes(x = x, y = y)) +
#'   geom_polygon_sample(aes(group = id, fill=value), alpha=0.1, times=20)
#' @export
geom_polygon_sample <- make_constructor(ggplot2::GeomPolygon, stat = "sample", times=10)