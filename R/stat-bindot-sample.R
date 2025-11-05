#' @importFrom ggplot2 ggproto StatBindot
#' @rdname geom_dotplot_sample
#' @format NULL
#' @usage NULL
#' @export
StatBindotSample <- ggplot2::ggproto("StatBindotSample", ggplot2::StatBindot,
                                  setup_params = function(self, data, params) {
                                    times <- params$times
                                    params$times <- 1
                                    data <- dibble_to_tibble(data, params)
                                    params <- ggplot2::ggproto_parent(ggplot2::StatBindot, self)$setup_params(data, params)
                                    params$times <- times
                                    params
                                  },
                                  
                                  setup_data = function(data, params) {
                                    dibble_to_tibble(data, params) 
                                  },
                                  
                                  extra_params = c("na.rm", "times", "binwidth", "binaxis", "method", "binpositions",
                                                   "origin", "right", "width", "drop")
)
