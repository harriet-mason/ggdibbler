#' @importFrom ggplot2 ggproto StatSummary2d
#' @rdname stat_summary_2d_sample
#' @format NULL
#' @usage NULL
#' @export
StatSummary2dSample <- ggplot2::ggproto("StatSummary2dSample", ggplot2::StatSummary2d,
                                        
                                        setup_params = function(self, data, params) {
                                          times <- params$times
                                          params$times <- 1
                                          data <- dibble_to_tibble(data, params)
                                          params <- ggplot2::ggproto_parent(ggplot2::StatSummary2d, 
                                                                            self)$setup_params(data, params)
                                          params$times <- times
                                          params
                                        },
                                        
                                        setup_data = function(data, params) {
                                          dibble_to_tibble(data, params) 
                                        },
                                        
                                        extra_params = c("na.rm", "times", "seed")
)

#' Bin and summarise in 2d (rectangle & hexagons) with uncertain inputs
#' 
#' Identical to stat_summary_2d, except that it will accept a distribution in 
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_summary_2d
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @examples
#' library(ggplot2)
#' d <- ggplot(smaller_diamonds, 
#'             aes(carat, depth, z = price))
#' d + stat_summary_2d()
#' 
#' b <- ggplot(smaller_uncertain_diamonds, 
#'             aes(carat, depth, z = price))
#' b + stat_summary_2d_sample()
#' 
#' # summary_hex
#' d + stat_summary_hex(fun = ~ sum(.x^2))
#' b + stat_summary_hex_sample(fun = ~ sum(.x^2))
#' @export
stat_summary_2d_sample <- make_constructor(StatSummary2dSample, geom = "tile", 
                                    times = 10, position="identity_dodge",
                                    alpha = 1/log(times), seed = NULL)

