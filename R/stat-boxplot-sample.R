#' @importFrom ggplot2 ggproto StatBoxplot
#' @rdname geom_boxplot_sample
#' @format NULL
#' @usage NULL
#' @export
StatBoxplotSample <- ggplot2::ggproto("StatBoxplotSample", ggplot2::StatBoxplot,
                                      setup_params = function(self, data, params) {
                                        # minimum param times for param training to reduce computations
                                        times <- params$times
                                        params$times <- 1
                                        # sample expand data for parameter training
                                        data <- dibble_to_tibble(data, params)
                                        # train parameters on original boxplot
                                        params <- ggplot2::ggproto_parent(ggplot2::StatBoxplot, self)$setup_params(data, params)
                                        params$times <- times
                                        params
                                      },
                                      
                                  setup_data = function(self, data, params) {
                                    # convert distributions to samples that can be plot
                                    data <- dibble_to_tibble(data, params)
                                    # run through geom_boxplot setup data function
                                    ggplot2::ggproto_parent(ggplot2::StatBoxplot, self)$setup_data(data, params)
                                  },
                                  
                                  extra_params = c("na.rm", "times", "outliers", "notch", 
                                                   "notchwidth", "staplewidth", "varwidth", 
                                                   "orientation", "show.legend", 
                                                   "inherit.aes", "coef")
                                  )

#' @export
#' @rdname geom_boxplot_sample
#' @inheritParams ggplot2::stat_boxplot
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_boxplot_sample <- make_constructor(StatBoxplotSample, geom = "boxplot", # position = "dodge2",
                                        times = 10, orientation = NA, omit = "width")


