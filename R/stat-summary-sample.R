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
                                                       "fun", "fun.min", "fun.max",
                                                       "fun.args")
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
#' @examples
#' library(ggplot2)
#' library(distributional)
#' d <- ggplot(mtcars, aes(cyl, mpg)) + geom_point()
#' d + stat_summary(fun.data = "mean_cl_boot", colour = "red")
#' 
#' b  <- ggplot(uncertain_mtcars, aes(cyl, mpg)) + geom_point_sample()
#' b + stat_summary_sample(fun.data = "mean_cl_boot", alpha=0.5,
#'                         colour = "red")
#' 
#' d + stat_summary(fun = "median", colour = "red", geom = "point")
#' b + stat_summary_sample(fun = "median", colour = "red", geom = "point")
#' 
#' d + aes(colour = factor(vs)) + stat_summary(fun = mean, geom="line")
#' b + aes(colour = dist_transformed(vs, factor, as.numeric)) + 
#'   stat_summary_sample(fun = mean, geom="line") +
#'   labs(colour = "factor(vs)")
#' @export
stat_summary_sample <- make_constructor(StatSummarySample, geom = "pointrange", 
                                        times = 10, size = 3/times,  
                                        linewidth= 3/times, alpha=0.7)