#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto StatIdentity
#' @rdname stat_sample
StatSample <- ggplot2::ggproto("StatSample", ggplot2::StatIdentity,
                               setup_data = function(data, params) {
                                 dibble_to_tibble(data, params)
                                 },
                               
                               extra_params = c("na.rm", "times")
)

#' Generates a sample from a distribution
#' 
#' Can think of as the ggdibbler equivalent to "stat_identity". It is the default stat
#' that we used for most geoms.
#' 
#' 
#' @export
#' @examples
#' library(ggplot2)
#' 
#' p <- ggplot(mtcars, aes(wt, mpg))
#' p + stat_identity()
#' 
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg))
#' q + stat_sample(aes(colour = after_stat(drawID)))
#' 
#' @importFrom ggplot2 layer 
#' @importFrom rlang list2
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::stat_identity
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_sample <- make_constructor(StatSample, geom = "point", times = 10)


