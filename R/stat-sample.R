#' @usage NULL
#' @format NULL
#' @importFrom ggplot2 ggproto Stat
#' @importFrom dplyr mutate group_by reframe across filter rename_with select slice n
#' @importFrom tidyselect all_of
#' @importFrom tidyr unnest_longer
#' @importFrom distributional is_distribution generate
#' @export
StatSample <- ggproto("StatSample", Stat,
                      compute_group = function(data, scales, n) {
                        sample_expand(data, n)
                      }
)

#' Visualise Points with Uncertainty
#' 
#' Identical to geom_point, except that it visualises a distribution of points. 
#' 
#' @importFrom ggplot2 aes layer
#' @importFrom rlang list2
#' @param n A parameter used to control the number of samples
#' @returns A ggplot2 geom representing a sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_point
#' @export
stat_sample <- function(mapping = NULL, data = NULL, 
                        geom = "point", position = "identity", 
                        na.rm = FALSE, show.legend = NA, 
                        inherit.aes = TRUE, n=10, ...) {
    ggplot2::layer(
      stat = StatSample, 
      data = data, 
      mapping = mapping, # mappingswap(mapping, data) swap mapping to avoid scale problem
      geom = geom, 
      position = position, 
      show.legend = show.legend, 
      inherit.aes = inherit.aes, 
      params = list(na.rm = na.rm,
                    n = n, ...)
      )
}

sample_expand <- function(data, times){ 
  # Check which variables are distributions
  distcols <- names(data)[sapply(data, is_distribution)]
  othcols <- setdiff(names(data), distcols)

  # Check for at least one distribution vector
  if(length(distcols)==0) return(data |> tibble::rowid_to_column(var = "distID"))
  
  # Can't filter warning because it comes from ggplot print step
    # Hold old data to avoid warning
  old_data <- data |>
    dplyr::select(distcols)|>
    dplyr::slice(rep(1:dplyr::n(), each = times))
  # Sample from distribution variables
  new_data <- data |>
    mutate(across(all_of(distcols), ~ generate(.x, times = times))) |>
    group_by(across(all_of(othcols))) |>
    unnest_longer(all_of(distcols)) |>
    dplyr::rename_with(~ sub("dist", "", .x, fixed = TRUE)) |>
    tibble::rowid_to_column(var = "distID") |>
    mutate(distID = distID%%times + 1)

  # send off combination of both
  cbind(old_data, new_data)
}

