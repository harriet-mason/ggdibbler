#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto StatSf ggproto_parent
#' @importFrom distributional generate
#' @rdname geom_sf_sample
StatSfSample <- ggproto("StatSfSample", StatSf,
                        setup_data = function(data, params) {
                          dibble_to_tibble(data, params)
                        },
                        # This is just here so setup_data has access to n
                        extra_params = c("na.rm", "times"),
                        
)





