#' @importFrom ggplot2 ggproto StatQq
#' @rdname geom_qq_sample
#' @format NULL
#' @usage NULL
#' @export
StatQqSample <- ggplot2::ggproto("StatQqSample", ggplot2::StatQq,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", 
                                                   "distribution", "dparams",
                                                   "seed")
)

#' A quantile-quantile plot with uncertainty
#' 
#' Identical to geom_qq, stat_qq, geom_gg_line, and stat_qq_line, except 
#' that they accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_qq
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' df <- data.frame(y = rt(200, df = 5))
#' uncertain_df <- data.frame(y=dist_normal(rt(200, df = 5), runif(200)))
#' 
#' # ggplot
#' p <- ggplot(df, aes(sample = y))
#' p + stat_qq() + stat_qq_line()
#' 
#' # ggdibbler
#' q <- ggplot(uncertain_df, aes(sample = y))
#' q + stat_qq_sample() + 
#'   stat_qq_line_sample()
#' 
#' # Using to explore the distribution of a variable
#' # ggplot
#' ggplot(mtcars, aes(sample = mpg)) +
#'   stat_qq() +
#'   stat_qq_line()
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(sample = mpg)) +
#'   stat_qq_sample() +
#'   stat_qq_line_sample()
#' @export
geom_qq_sample <- make_constructor(StatQqSample, geom = "point", 
                                   omit = "quantiles", times=10,
                                   alpha = 1/log(times), seed = NULL)

#' @export
#' @rdname geom_qq_sample
stat_qq_sample <- geom_qq_sample




