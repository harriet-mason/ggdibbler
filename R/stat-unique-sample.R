#' @importFrom ggplot2 ggproto StatUnique
#' @rdname stat_unique_sample
#' @format NULL
#' @usage NULL
#' @export
StatUniqueSample <- ggplot2::ggproto("StatUniqueSample", ggplot2::StatUnique,
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times")
)

#' Remove duplicates (with uncertainty?)
#' 
#' Identical to stat_unique, except that it will accept a distribution in place
#'  of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_unique
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @examples
#' # ggplot 1
#' ggplot(mtcars, aes(vs, am)) +
#'   geom_point(alpha = 0.1)
#' # ggdibbler 1
#' ggplot(uncertain_mtcars2, aes(vs, am)) +
#'   geom_point_sample(alpha = 0.01, size=5)
#' 
#' # ggplot 2
#' ggplot(mtcars, aes(vs, am)) +
#'   geom_point(alpha = 0.1, stat = "unique")
#' # ggdibbler 2
#' ggplot(uncertain_mtcars2, aes(vs, am)) +
#'   geom_point_sample(alpha = 0.1, , size=5, stat = "unique_sample")
#' @export
stat_unique_sample <- make_constructor(StatUniqueSample, geom = "point", 
                                       times = 10)
