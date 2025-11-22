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
                                     }
                                      setup_data = function(data, params) {
                                        dibble_to_tibble(data, params) 
                                      },
                                      
                                      extra_params = c("na.rm", "times")
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
#' @examples
#' print("replace me")
#' @export
stat_manual_sample <- make_constructor(StatManualSample, geom = "point", 
                                       times = 10)



