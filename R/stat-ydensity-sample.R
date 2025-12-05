#' @importFrom ggplot2 ggproto StatYdensity
#' @rdname geom_violin_sample
#' @format NULL
#' @usage NULL
#' @export
StatYdensitySample <- ggplot2::ggproto("StatYdensitySample", ggplot2::StatYdensity,
                                  setup_params = function(self, data, params) {
                                    times <- params$times
                                    params$times <- 1
                                    data <- dibble_to_tibble(data, params)
                                    params <- ggplot2::ggproto_parent(ggplot2::StatYdensity, self)$setup_params(data, params)
                                    params$times <- times
                                    params
                                   },
                                  
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @export
#' @rdname geom_violin_sample
#' @inheritParams ggplot2::stat_ydensity
stat_ydensity_sample <- make_constructor(StatYdensitySample, geom = "violin", 
                                         times = 10, seed = NULL, 
                                         orientation = NA,
                                         checks = exprs(scale <- arg_match0(scale, c("area", "count", "width"))),
                                         omit = "width")




