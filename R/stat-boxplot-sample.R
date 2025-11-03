#' @importFrom ggplot2 ggproto StatBoxplot self
#' @rdname geom_boxplot_sample
#' @format NULL
#' @usage NULL
#' @export
StatBoxplotSample <- ggplot2::ggproto("StatBoxplotSample", ggplot2::StatBoxplot,
                                      setup_params = function(self, data, params) {
                                        params$flipped_aes <- has_flipped_aes(data, params, main_is_orthogonal = TRUE,
                                                                              group_has_equal = TRUE,
                                                                              main_is_optional = TRUE,
                                                                              default = NA)
                                        
                                        if (is.na(params$flipped_aes) && any(c("x", "y") %in% names(data))) {
                                          cli::cli_warn("Orientation is not uniquely specified when both the x and y aesthetics are continuous. Picking default orientation 'x'.")
                                          params$flipped_aes <- FALSE
                                        }
                                        data <- flip_data(data, params$flipped_aes)
                                        
                                        has_x <- !(is.null(data$x) && is.null(params$x))
                                        has_y <- !(is.null(data$y) && is.null(params$y))
                                        if (!has_x && !has_y) {
                                          cli::cli_abort("{.fn {snake_class(self)}} requires an {.field x} or {.field y} aesthetic.")
                                        }
                                        
                                        params$width <- params$width %||% (resolution_dist(data$x %||% 0, discrete = TRUE) * 0.75)
                                        
                                        if (!ggplot2:::is_mapped_discrete(data$x) && is.double(data$x) && !has_groups(data) && any(data$x != data$x[1L])) {
                                          cli::cli_warn(c(
                                            "Continuous {.field {flipped_names(params$flipped_aes)$x}} aesthetic",
                                            "i" = "did you forget {.code aes(group = ...)}?"
                                          ))
                                        }
                                        
                                        params
                                      },
                                      
                                  setup_data = function(self, data, params) {
                                    data <- dibble_to_tibble(data, params)
                                    print("groups 1")
                                    print(table(data$group))
                                    data <- ggplot2::ggproto_parent(ggplot2::StatBoxplot, self)$setup_data(data, params)
                                    print("groups 2")
                                    print(table(data$group))
                                    data
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


