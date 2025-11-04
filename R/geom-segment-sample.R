#' Line segments and curves with uncertainty
#' 
#' Identical to geom_segment, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_segment
#' @importFrom ggplot2 make_constructor GeomSegment
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' # ggplot
#' b <- ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point()
#' # ggdibbler
#' a <- ggplot(uncertain_mtcars, aes(wt, mpg)) +
#'   geom_point_sample(size=0.1) +
#'   scale_x_continuous_distribution(limits = c(1,6)) +
#'   scale_y_continuous_distribution(limits = c(8,36))
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
#'                     data = uncertain_df, alpha=0.5) +
#'   geom_segment_sample(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "segment"), 
#'                       data = uncertain_df, alpha=0.5)
#' 
#' # ggplot
#' b + geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2), data = df, curvature = -0.2)
#' 
#' # ggdibbler
#' a + geom_curve_sample(aes(x = x1, y = y1, xend = x2, yend = y2), curvature = -0.2,
#'                       data = uncertain_df, alpha=0.5)
#' 
#' # ggplot
#' b + geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2), data = df, curvature = 1)
#' # ggdibbler
#' a + geom_curve_sample(aes(x = x1, y = y1, xend = x2, yend = y2), 
#'                       data = uncertain_df, alpha=0.5, curvature = 1)
#' 
#' 
#' # ggplot
#' b + geom_curve(
#'   aes(x = x1, y = y1, xend = x2, yend = y2),
#'   data = df,
#'   arrow = arrow(length = unit(0.03, "npc"))
#' )
#' 
#' # ggdibbler
#' a + geom_curve_sample(
#'   aes(x = x1, y = y1, xend = x2, yend = y2),
#'   data = uncertain_df, alpha=0.5,
#'   arrow = arrow(length = unit(0.03, "npc"))
#' )
#' 
#' # You can also use geom_segment to recreate plot(type = "h") :
#' set.seed(1)
#' # deterministic data
#' counts <- as.data.frame(table(x = rpois(100,5)))
#' counts$x <- as.numeric(as.character(counts$x))
#' # random data
#' uncertain_counts <- counts
#' uncertain_counts$Freq <- dist_binomial(counts$Freq, 0.9)
#' 
#' # ggplot
#' ggplot(counts, aes(x, Freq)) +
#'   geom_segment(aes(xend = x, yend = 0), linewidth = 10, lineend = "butt")
#' 
#' # ggdibbler
#' ggplot(uncertain_counts, aes(x, Freq)) +
#'   geom_segment_sample(aes(xend = x, yend = 0), linewidth = 10, lineend = "butt", alpha=0.1) +
#'   scale_x_continuous_distribution(limits = c(0,12)) +
#'   scale_y_continuous_distribution(limits = c(0,25)) 
#' @export
geom_segment_sample <- make_constructor(ggplot2::GeomSegment, stat = "identity_sample", times=10)
