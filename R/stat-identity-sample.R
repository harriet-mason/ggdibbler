#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto Stat
#' @rdname stat_identity_sample
StatIdentitySample <- ggplot2::ggproto("StatIdentitySample", ggplot2::StatIdentity,
                               setup_data = function(data, params) {
                                 dibble_to_tibble(data, params)
                                 },
                               
                               extra_params = c("na.rm", "times", "seed")
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
#' q + stat_identity_sample(aes(colour = after_stat(drawID)))
#' 
#' @importFrom ggplot2 layer 
#' @importFrom rlang list2
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::stat_identity
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
stat_identity_sample <- make_constructor(StatIdentitySample, geom = "point", 
                                         times = 10, alpha = 1/log(times), 
                                         seed = NULL)


