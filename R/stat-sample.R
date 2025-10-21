#' Generates a sample then leaves data as is
#' 
#' Can think of as the ggdibbler equivalent to "stat_identity". It is the default stat
#' that we used for most geoms.
#' @export
#' @examples
#' library(ggplot2)
#' library(distributional)
#' set.seed(1997)
#' point_data <- data.frame(
#'   random_x = c(dist_uniform(2,3),
#'                dist_normal(3,2), 
#'              dist_exponential(3)),
#'   random_y = c(dist_gamma(2,1),
#'              dist_sample(x = list(rnorm(100, 5, 1))),
#'              dist_exponential(1)),
#'   class = c("A", "B", "C"))
#'   
#' # basic random variables x and y
#' ggplot() + 
#'   stat_sample(data = point_data, aes(x=random_x, y=random_y))
#'   
#' ggplot() + 
#'   stat_sample(data = point_data, aes(x=random_x, y=random_y, label=class), geom="text")
#' 
#' @importFrom ggplot2 layer 
#' @importFrom rlang list2
#' @inheritParams geom_point_sample
stat_sample <- function(mapping = NULL, data = NULL, 
                        geom = "point", position = "identity", 
                        na.rm = FALSE, show.legend = NA, 
                        inherit.aes = TRUE, times = 30, ...) {
  
  layer(
    stat = StatSample, 
    data = data, 
    mapping = mapping, # mappingswap(mapping, data) swap mapping to avoid scale problem
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list2(na.rm = na.rm,
                  times = times, ...)
  )
}

#' @export
#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto Stat
#' @rdname stat_sample
StatSample <- ggproto("StatSample", Stat,
                      setup_data = function(data, params) {
                        sample_expand(data, params$times)
                      },
                      compute_group = function(self, data, scales, times) {
                        data
                      }
)

#' @keywords internal
sample_expand <- function(data, times){ 
  # Check which variables are distributions
  distcols <- names(data)[sapply(data, distributional::is_distribution)]
  othcols <- setdiff(names(data), distcols)
  
  # Check for at least one distribution vector
  if(length(distcols)==0) return(data)
  
  # Sample from distribution variables
  data |>
    dplyr::mutate(dplyr::across(dplyr::all_of(distcols), ~ distributional::generate(.x, times = times))) |>
    dplyr::group_by(dplyr::across(dplyr::all_of(othcols))) |>
    tidyr::unnest_longer(dplyr::all_of(distcols)) |>
    tibble::rowid_to_column(var = "drawID") |>
    dplyr::mutate(drawID = drawID%%times + 1)

}

