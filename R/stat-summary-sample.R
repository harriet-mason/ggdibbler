#' @importFrom ggplot2 ggproto StatSummary
#' @rdname stat_summary_sample
#' @format NULL
#' @usage NULL
#' @export
StatSummarySample <- ggplot2::ggproto("StatSummarySample", ggplot2::StatSummary,
                                      setup_params = function(self, data, params) {
                                        times <- params$times
                                        params$times <- 1
                                        data <- dibble_to_tibble(data, params)
                                        params <- ggplot2::ggproto_parent(ggplot2::StatSummary, self)$setup_params(data, params)
                                        params$times <- times
                                        params
                                      },
                                      setup_data = function(data, params) {
                                        dibble_to_tibble(data, params) 
                                      },
                                      extra_params = c("na.rm", "times", "fun.data", 
                                                       "bins", "seed",
                                                       "fun", "fun.min", "fun.max", 
                                                       "binwidth", "breaks",
                                                       "fun.args", "orientation", 
                                                       "show.legend", "inherit.aes")
)

#' Summarise y values at unique/binned x with uncertainty
#' 
#' Identical to stat_summary, except that it will accept a distribution in 
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_summary
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' d <- ggplot(mtcars, aes(cyl, mpg)) + geom_point()
#' b  <- ggplot(uncertain_mtcars, aes(cyl, mpg)) + geom_point_sample(seed=4)
#' 
#' d + stat_summary(fun = "median", colour = "red", geom = "point")
#' b + stat_summary_sample(fun = "median", colour = "red", geom = "point")
#' 
#' d + aes(colour = factor(vs)) + stat_summary(fun = mean, geom="line")
#' b + aes(colour = dist_transformed(vs, factor, as.numeric)) + 
#'   stat_summary_sample(fun = mean, geom="line", seed=4) +
#'   labs(colour = "factor(vs)")
#' @export
stat_summary_sample <- make_constructor(StatSummarySample, geom = "pointrange", 
                                        times = 10, alpha = 1/log(times), 
                                        seed = NULL)