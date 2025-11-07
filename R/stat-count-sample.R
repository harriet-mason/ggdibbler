#' @importFrom ggplot2 ggproto StatCount
#' @rdname geom_bar_sample
#' @format NULL
#' @usage NULL
#' @export
StatCountSample <- ggplot2::ggproto("StatCountSample", ggplot2::StatCount,
                                    setup_params = function(self, data, params) {
                                      times <- params$times
                                      params$times <- 1
                                      data <- dibble_to_tibble(data, params)
                                      params <- ggplot2::ggproto_parent(ggplot2::StatCount, self)$setup_params(data, params)
                                      params$times <- times
                                      params
                                    },
                                  
                                    setup_data = function(data, params) {
                                      dibble_to_tibble(data, params)
                                    },
                                  
                                  extra_params = c("na.rm", "times", "orientation",
                                                   "width", "flipped_aes"),
                                  
                                  
)

#' @export
#' @rdname geom_count_sample
#' @importFrom ggplot2 make_constructor StatCount
#' @inheritParams ggplot2::stat_count
#' @param times A parameter used to control the number of values sampled from each distribution. 
stat_count_sample <- make_constructor(
  ggplot2::StatCount, geom = "bar", # position = "stack",
  orientation = NA, omit = "width", times=10,
)

