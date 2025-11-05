#' Vertical intervals: lines, crossbars & errorbars with uncertainty
#' 
#' Identical to geom_linerange, geom_errorbar, geom_crossbar, and geom_pointrange
#' except that they will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_linerange
#' @importFrom ggplot2 make_constructor GeomLinerange
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(distributional)
#' # Create a simple example dataset
#' df <- data.frame(
#'   trt = factor(c(1, 1, 2, 2)),
#'   resp = c(1, 5, 3, 4),
#'   group = factor(c(1, 2, 1, 2)),
#'   upper = c(1.1, 5.3, 3.3, 4.2),
#'   lower = c(0.8, 4.6, 2.4, 3.6)
#' )
#' 
#' 
#' uncertain_df <- df |>
#'   group_by(trt, group) |>
#'   mutate(resp = dist_normal(resp, runif(1,0,0.2)),
#'          upper = dist_normal(upper, runif(1,0,0.2)),
#'          lower = dist_normal(lower, runif(1,0,0.2))
#'   )
#' 
#' p <- ggplot(df, aes(trt, resp, colour = group))
#' q <- ggplot(uncertain_df, aes(trt, resp, colour = group))
#' 
#' # ggplot
#' p + geom_linerange(aes(ymin = lower, ymax = upper))
#' #ggdibbler
#' q + geom_linerange_sample(aes(ymin = lower, ymax = upper), , alpha=0.7,
#'                           position=position_jitter(height=0, width=0.05))
#' 
#' # ggplot
#' p + geom_pointrange(aes(ymin = lower, ymax = upper))
#' # ggdibbler
#' q + geom_pointrange_sample(aes(ymin = lower, ymax = upper), alpha= 0.3,) 
#' 
#' # ggplot
#' p + geom_crossbar(aes(ymin = lower, ymax = upper), width = 0.2)
#' # ggdibbler
#' q + geom_crossbar_sample(aes(ymin = lower, ymax = upper), width = 0.2)
#' 
#' # ggplot
#' p + geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2)
#' # ggdibbler
#' q + geom_errorbar_sample(aes(ymin = lower, ymax = upper), width = 0.2)
#' 
#' # Flip the orientation by changing mapping
#' # ggplot
#' ggplot(df, aes(resp, trt, colour = group)) +
#'   geom_linerange(aes(xmin = lower, xmax = upper))
#' # ggdibbler
#' ggplot(uncertain_df, aes(resp, trt, colour = group)) +
#'   geom_linerange_sample(aes(xmin = lower, xmax = upper), alpha=0.7,
#'                         position=position_jitter(height=0.05, width=0))
#' 
#' # Draw lines connecting group means
#' # ggplot
#' p +
#'   geom_line(aes(group = group)) +
#'   geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2)
#' # ggdibbler
#' q +
#'   geom_line_sample(aes(group = group), alpha=0.5) +
#'   geom_errorbar_sample(aes(ymin = lower, ymax = upper), width = 0.2, alpha=0.5)
#' @export
geom_linerange_sample <- make_constructor(ggplot2::GeomLinerange, stat = "identity_sample", 
                                          times=10, orientation = NA)

