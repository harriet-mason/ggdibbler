#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto Stat
#' @importFrom dplyr mutate group_by reframe across filter
#' @importFrom tidyselect all_of
#' @importFrom tidyr unnest_longer
#' @importFrom distributional is_distribution generate
#' @export
StatSample <- ggproto("StatSample", Stat,
                      compute_group = function(data, scales, n) {
                        # Check which variables are distributions
                        distcols <- names(named_data)[sapply(named_data, is_distribution)]
                        othcols <- setdiff(names(named_data), distcols)
                                 
                        # Sample from distribution variables
                        data |>
                          mutate(across(all_of(distcols), ~ generate(.x, times = n))) |>
                          group_by(across(all_of(othcols))) |>
                          tidyr::unnest_longer(all_of(distcols))
                        }
)

stat_sample <- function(mapping = NULL, data = NULL, 
                        geom = "point", position = "identity", 
                        na.rm = FALSE, show.legend = NA, 
                        inherit.aes = TRUE, n=10, ...) {
  ggplot2::layer(
    stat = StatSample, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm,
                  n = n, ...)
  )
}



