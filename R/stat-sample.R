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
    dplyr::mutate(drawID = drawID%%times + 1) |>
    dplyr::mutate(group = abs(group*drawID ))

}

#' Generates a sample from a distribution
#' 
#' Can think of as the ggdibbler equivalent to "stat_identity". It is the default stat
#' that we used for most geoms.
#' 
#' 
#' @export
#' @examples
#' library(ggplot2)
#' 
#' p <- ggplot(mtcars, aes(wt, mpg))
#' p + stat_identity()
#' 
#' q <- ggplot(uncertain_mtcars, aes(wt, mpg))
#' q + stat_sample(aes(colour = after_stat(drawID)))
#' 
#' @importFrom ggplot2 layer 
#' @importFrom rlang list2
#' @returns A ggplot2 geom representing a point_sample which can be added to a ggplot object
#' @inheritParams ggplot2::stat_identity
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_sample <- make_constructor(StatSample, geom = "point", times = 10)


