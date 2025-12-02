#' @importFrom ggplot2 ggproto StatAlign
#' @rdname geom_ribbon_sample
#' @format NULL
#' @usage NULL
#' @export
StatAlignSample <- ggplot2::ggproto("StatAlignSample", ggplot2::StatAlign,
                                    
                                    setup_params = function(self, data, params) {
                                      # minimum param times for param training to reduce computations
                                      times <- params$times
                                      params$times <- 1
                                      # sample expand data for parameter training
                                      data <- dibble_to_tibble(data, params)
                                      # train parameters on original boxplot
                                      params <- ggplot2::ggproto_parent(ggplot2::StatAlign, self)$setup_params(data, params)
                                      params$times <- times
                                      params
                                    },
                                    
                                    setup_data = function(data, params) {
                                      dibble_to_tibble(data, params)
                                      },
                                  
                                  extra_params = c("na.rm", "times", "seed")
)

#' @export
#' @rdname geom_ribbon_sample
#' @inheritParams ggplot2::stat_align
stat_align_sample <- make_constructor(StatAlignSample, geom = "area",
                                      times = 10, seed = NULL, alpha=1/log(times),
                                      omit = c("unique_loc", "adjust"))
