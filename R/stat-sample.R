#' @export
#' @importFrom ggplot2 layer 
#' @importFrom rlang list2
#' @rdname geom_sf_sample
#' @inheritParams geom_sf_sample
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
#' @rdname geom_sf_sample
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

