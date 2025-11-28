#' @importFrom ggplot2 ggproto StatConnect
#' @rdname stat_connect_sample
#' @format NULL
#' @usage NULL
#' @export
StatConnectSample <- ggplot2::ggproto("StatConnectSample", ggplot2::StatConnect,
                                      setup_params = function(self, data, params) {
                                        times <- params$times
                                        params$times <- 1
                                        data <- dibble_to_tibble(data, params)
                                        params <- ggplot2::ggproto_parent(ggplot2::StatConnect, 
                                                                          self)$setup_params(data, params)
                                        params$times <- times
                                        params
                                      },
                                      
                                      setup_data = function(data, params) {
                                        dibble_to_tibble(data, params)
                                        },
                                      
                                      extra_params = c("na.rm", "times", "seed")
)

#' Connect uncertain observations
#' 
#' Identical to stat_connect, except that it will accept a distribution in 
#' place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_connect
#' @importFrom ggplot2 make_constructor
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @param seed Set the seed for the layers random draw, allows you to plot the
#' same draw across multiple layers.
#' @param alpha ggplot2 alpha, i.e. transparency. It is included as a 
#' parameter to make sure the repeated draws are always visible
#' @examples
#' # set up data
#' x <- seq(0, 1, length.out = 20)[-1]
#' smooth <- cbind(x, scales::rescale(1 / (1 + exp(-(x * 10 - 5)))))
#' zigzag <- cbind(c(0.4, 0.6, 1), c(0.75, 0.25, 1))
#' 
#' # ggplot
#' ggplot(head(economics, 10), aes(date, unemploy)) +
#'   stat_connect(aes(colour = "zigzag"), connection = zigzag) +
#'   stat_connect(aes(colour = "smooth"), connection = smooth) +
#'   geom_point()
#' # ggdibbler
#' ggplot(head(uncertain_economics, 10), aes(date, unemploy)) +
#'   stat_connect_sample(aes(colour = "zigzag"), connection = zigzag, seed=64) +
#'   stat_connect_sample(aes(colour = "smooth"), connection = smooth, seed=64) +
#'   geom_point_sample(seed=64) 
#' @export
stat_connect_sample <- make_constructor(StatConnectSample, geom = "path",
                                        times = 10, alpha = 1/log(times), 
                                        seed = NULL)


