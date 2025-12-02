#' @importFrom ggplot2 ggproto StatUnique
#' @rdname stat_unique_sample
#' @format NULL
#' @usage NULL
#' @export
StatUniqueSample <- ggplot2::ggproto("StatUniqueSample", ggplot2::StatUnique,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' Remove duplicates (with uncertainty?)
#' 
#' Identical to stat_unique, except that it will accept a distribution in place
#'  of any of the usual aesthetics. Note that the values will only be unique
#'  within each draw, (at the final plot level you might still have double ups).
#' 
#' @inheritParams ggplot2::stat_unique
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @examples
#' library(ggplot2)
#' # ggplot
#' ggplot(mtcars, aes(vs, am)) +
#'   geom_point(alpha = 0.1)
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(vs, am)) +
#'   geom_point_sample(alpha = 0.01)
#' 
#' # ggplot
#' ggplot(mtcars, aes(vs, am)) +
#'   geom_point(alpha = 0.1, stat = "unique")
#' # ggdibbler
#' ggplot(uncertain_mtcars, aes(vs, am)) +
#'   geom_point_sample(alpha = 0.01, stat = "unique_sample")
#' @export
stat_unique_sample <- make_constructor(StatUniqueSample, geom = "point", 
                                       times = 10, alpha = 1/log(times), seed = NULL)
