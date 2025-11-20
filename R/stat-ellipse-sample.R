#' @importFrom ggplot2 ggproto StatEllipse
#' @rdname stat_ellipse_sample
#' @format NULL
#' @usage NULL
#' @export
StatEllipseSample <- ggplot2::ggproto("StatEllipseSample", ggplot2::StatEllipse,
                                      setup_params = function(self, data, params) {
                                        
                                        times <- params$times
                                        params$times <- 1
                                        data <- dibble_to_tibble(data, params)
                                        params <- ggplot2::ggproto_parent(ggplot2::StatEllipse, self)$setup_params(data, params)
                                        params$times <- times
                                        params
                                      },
                                      setup_data = function(data, params) {
                                        dibble_to_tibble(data, params) 
                                      },
                                      
                                      extra_params = c("na.rm", "times")
)

#' Compute normal data ellipses with uncertainty
#' 
#' Identical to stat_ellipse, except that it will accept a distribution 
#' in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::stat_ellipse
#' @importFrom ggplot2 make_constructor 
#' @param times A parameter used to control the number of values sampled from 
#' each distribution.
#' @examples
#' library(ggplot2)
#' library(distributional)
#' # ggplot
#' ggplot(faithful, aes(waiting, eruptions)) +
#'   geom_point() +
#'   stat_ellipse()
#' # ggdibbler
#' ggplot(uncertain_faithful, aes(waiting, eruptions)) +
#'   geom_point_sample() +
#'   stat_ellipse_sample()
#'   
#' # ggplot
#' ggplot(faithful, aes(waiting, eruptions, color = eruptions > 3)) +
#'   geom_point() +
#'   stat_ellipse(type = "norm", linetype = 2) +
#'   stat_ellipse(type = "t")
#' # ggdibbler
#' ggplot(uncertain_faithful,
#'        aes(waiting, eruptions,
#'            color = dist_transformed(eruptions,function(x) x > 3, identity))) +
#'   geom_point_sample() +
#'   stat_ellipse_sample(type = "norm", linetype = 2) +
#'   stat_ellipse_sample(type = "t") +
#'   labs(colour = "eruptions > 3")
#' 
#' # ggplot
#' ggplot(faithful, aes(waiting, eruptions, fill = eruptions > 3)) +
#'   stat_ellipse(geom = "polygon")
#' # ggdibbler
#' ggplot(uncertain_faithful,
#'        aes(waiting, eruptions,
#'            fill = dist_transformed(eruptions, function(x) x > 3, identity))) +
#'   stat_ellipse_sample(geom = "polygon", alpha=0.1) +
#'   labs(fill = "eruptions > 3")
#' @export
stat_ellipse_sample <- make_constructor(StatEllipseSample, geom = "path", times = 10,
                                        alpha=0.7, linewidth = 3/times)


