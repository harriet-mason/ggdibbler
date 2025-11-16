#' @importFrom ggplot2 ggproto StatContour
#' @rdname geom_contour_sample
#' @format NULL
#' @usage NULL
#' @export
StatContourSample <- ggplot2::ggproto("StatContourSample", ggplot2::StatContour,
                                  setup_params = function(self, data, params) {
                                    times <- params$times
                                    params$times <- 1
                                    data <- dibble_to_tibble(data, params)
                                    params <- ggplot2::ggproto_parent(ggplot2::StatContour, self)$setup_params(data, params)
                                    params$times <- times
                                    params
                                  },
                                  
                                  setup_data = function(self, data, params) {
                                    data <- dibble_to_tibble(data, params) 
                                    ggproto_parent(StatContour, self)$setup_data(data, scales)
                                    data
                                  },
                                  
                                  extra_params = c("na.rm", "times")
)

#' @importFrom ggplot2 ggproto StatContourFilled
#' @rdname geom_contour_sample
#' @format NULL
#' @usage NULL
#' @export
StatContourFilledSample <- ggplot2::ggproto("StatContourFilledSample", ggplot2::StatContourFilled,
                                      setup_params = function(self, data, params) {
                                        times <- params$times
                                        params$times <- 1
                                        data <- dibble_to_tibble(data, params)
                                        params <- ggplot2::ggproto_parent(ggplot2::StatContour, self)$setup_params(data, params)
                                        params$times <- times
                                        params
                                      },
                                      
                                      setup_data = function(self, data, params) {
                                        data <- dibble_to_tibble(data, params) 
                                        ggproto_parent(StatContourFilled, self)$setup_data(data, scales)
                                      },
                                      
                                      extra_params = c("na.rm", "times")
)

#' @export
#' @rdname geom_contour_sample
#' @inheritParams ggplot2::stat_contour
#' @param times A parameter used to control the number of values sampled 
#' from each distribution.
stat_contour_sample <- make_constructor(StatContourSample,
                                        geom = "contour", 
                                        times = 10,
                                        omit = "z.range"
                                        )

#' @export
#' @rdname geom_contour_sample
#' @inheritParams ggplot2::stat_contour_filled
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_contour_filled_sample <- make_constructor(StatContourFilledSample, 
                                               geom = "contour_filled", 
                                               times = 10,
                                               omit = "z.range")

