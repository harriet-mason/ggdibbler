#' @importFrom ggplot2 ggproto StatCount
#' @rdname geom_bar_sample
#' @format NULL
#' @usage NULL
#' @export
StatCountSample <- ggplot2::ggproto("StatCountSample", ggplot2::StatCount,
                                    setup_params = function(self, data, params) {
                                      params$flipped_aes <- has_flipped_aes(data, params, main_is_orthogonal = FALSE)
                                      
                                      has_x <- !(is.null(data$x) && is.null(params$x))
                                      has_y <- !(is.null(data$y) && is.null(params$y))
                                      if (!has_x && !has_y) {
                                        cli::cli_abort("{.fn {snake_class(self)}} requires an {.field x} or {.field y} aesthetic.")
                                      }
                                      if (has_x && has_y) {
                                        cli::cli_abort("{.fn {snake_class(self)}} must only have an {.field x} {.emph or} {.field y} aesthetic.")
                                      }
                                      if (is.null(params$width)) {
                                        x <- if (params$flipped_aes) "y" else "x"
                                        params$width <- resolution_dist(data[[x]], discrete = TRUE) * 0.9
                                      }
                                      
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
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
stat_count_sample <- make_constructor(
  ggplot2::StatCount, geom = "bar", # position = "stack",
  orientation = NA, omit = "width", times=10,
)


#' @keywords internal
resolution_dist <- function(x, zero = TRUE, discrete = FALSE) {
  if(distributional::is_distribution(x)){
    x <- unlist(generate(x, 10))
  }
  resolution(x)
}