#' @importFrom ggplot2 ggproto StatManual
#' @rdname stat_manual_sample
#' @format NULL
#' @usage NULL
#' @export
StatManualSample <- ggplot2::ggproto("StatManualSample", ggplot2::StatManual,
                                     setup_params = function(self, data, params) {
                                       times <- params$times
                                       params$times <- 1
                                       data <- dibble_to_tibble(data, params)
                                       params <- ggplot2::ggproto_parent(ggplot2::StatManual, 
                                                                         self)$setup_params(data, 
                                                                                            params)
                                       params$times <- times
                                       params
                                     },
                                      setup_data = function(data, params) {
                                        dibble_to_tibble(data, params) 
                                      },
                                      
                                      extra_params = c("na.rm", "times", "seed")
)

#' Manually compute transformations with uncertainty
#' 
#' Identical to stat_manual, except that it will accept a distribution in 
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_manual
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @returns A ggplot2 layer
#' @examples
#' library(ggplot2)
#' library(distributional)
#' # A standard scatterplot
#' p <- ggplot(mtcars, 
#'             aes(disp, mpg, colour = factor(cyl))) +
#'   geom_point()
#' 
#' q <- ggplot(uncertain_mtcars, 
#'             aes(disp, mpg, 
#'                 colour = dist_transformed(cyl, factor, as.numeric))) +
#'   labs(colour="factor(cyl)") +
#'   geom_point_sample()
#' 
#' # Using a custom function
#' make_hull <- function(data) {
#'   hull <- chull(x = data$x, y = data$y)
#'   data.frame(x = data$x[hull], y = data$y[hull])
#' }
#' 
#' p + stat_manual(
#'   geom = "polygon",
#'   fun  = make_hull,
#'   fill = NA
#' )
#' 
#' q + stat_manual_sample(
#'   geom = "polygon",
#'   fun  = make_hull,
#'   fill = NA,
#' )
#' # Using the `transform` function with quoting
#' p + stat_manual(
#'   geom = "segment",
#'   fun  = transform,
#'   args = list(
#'     xend = quote(mean(x)),
#'     yend = quote(mean(y))
#'   )
#' )
#' 
#' q + stat_manual_sample(
#'   geom = "segment",
#'   fun  = transform,
#'   args = list(
#'     xend = quote(mean(x)),
#'     yend = quote(mean(y))
#'   )
#' )
#' 
#' # Using dplyr verbs with `vars()`
#' if (requireNamespace("dplyr", quietly = TRUE)) {
#'   
#'   # Get centroids with `summarise()`
#'   p + stat_manual(
#'     size = 10, shape = 21,
#'     fun  = dplyr::summarise,
#'     args = vars(x = mean(x), y = mean(y))
#'   )
#'   
#'   q + stat_manual_sample(
#'     size = 10, shape = 21,
#'     fun  = dplyr::summarise,
#'     args = vars(x = mean(x), y = mean(y))
#'   )
#' }
#' @export
stat_manual_sample <- make_constructor(StatManualSample, geom = "point", 
                                       times = 10, seed = NULL)



