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
                                      extra_params = c("na.rm", "times", "seed",
                                                       "orientation", "fun.data", 
                                                       "fun.max", "fun.min", 
                                                       "fun.args")
)

#' Summarise y values at unique/binned x with uncertainty
#' 
#' Identical to stat_summary, except that it will accept a distribution in 
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_summary
#' @inheritParams ggplot2::stat_summary_bin
#' @importFrom ggplot2 layer
#' @importFrom rlang list2
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
stat_summary_sample <- function(mapping = NULL, data = NULL, times = 10, seed = NULL,
                         geom = "pointrange", position = "identity",
                         ...,
                         fun.data = NULL,
                         fun = NULL,
                         fun.max = NULL,
                         fun.min = NULL,
                         fun.args = list(),
                         na.rm = FALSE,
                         orientation = NA,
                         show.legend = NA,
                         inherit.aes = TRUE,
                         fun.y = deprecated(),
                         fun.ymin = deprecated(),
                         fun.ymax = deprecated()) {
  if (lifecycle::is_present(fun.y)) {
    fun <- fun %||% fun.y
  }
  if (lifecycle::is_present(fun.ymin)) {
    fun.min <- fun.min %||% fun.ymin
  }
  if (lifecycle::is_present(fun.ymax)) {
    fun.max <- fun.max %||% fun.ymax
  }
  layer(
    data = data,
    mapping = mapping,
    stat = StatSummarySample,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list2(
      times = times,
      seed = seed,
      fun.data = fun.data,
      fun = fun,
      fun.max = fun.max,
      fun.min = fun.min,
      fun.args = fun.args,
      na.rm = na.rm,
      orientation = orientation,
      ...
    )
  )
}

