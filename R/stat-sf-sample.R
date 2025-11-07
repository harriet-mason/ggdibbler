#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto StatSf ggproto_parent
#' @importFrom distributional generate
#' @rdname geom_sf_sample
StatSfSample <- ggproto("StatSfSample", StatSf,
                        setup_data = function(data, params) {
                          sample_subdivide_sf(data, params$times)
                        },
                        # This is just here so setup_data has access to n
                        extra_params = c("na.rm", "times"),
                        compute_panel = function(self, data, scales, coord, times) {
                          ggproto_parent(StatSf, self)$compute_panel(data, scales, coord)
                          }
                        
)





