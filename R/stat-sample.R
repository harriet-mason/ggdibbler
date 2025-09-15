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
                        
                        # Check which variables are distributions
                        distcols <- names(data)[sapply(data, is_distribution)]
                        othcols <- setdiff(names(data), distcols)
                        
                        # Hold old data to add back in to avoid warning
                        old_data <- data |>
                          dplyr::select(distcols)|>
                          dplyr::slice(rep(1:dplyr::n(), each = n))
                        
                        # add xdist and ydist to old_data in if not already in
                        # should I add all aesthetics of them
                        #
                      
                        # Sample from distribution variables
                        new_data <- data |>
                          mutate(across(all_of(distcols), ~ generate(.x, times = n))) |>
                          group_by(across(all_of(othcols))) |>
                          unnest_longer(all_of(distcols)) |>
                          dplyr::rename_with(~ sub("dist", "", .x, fixed = TRUE))
                        
                        # send off combination of both
                        cbind(old_data, new_data)
                      }
                      # required_aes = all geom_point aes
)

stat_sample <- function(mapping = NULL, data = NULL, 
                        geom = "point", position = "identity", 
                        na.rm = FALSE, show.legend = NA, 
                        inherit.aes = TRUE, n=10, ...) {

  ggplot2::layer(
    stat = StatSample, 
    data = data, 
    mapping = mappingswap(mapping, data), #swap mapping to avoid scale problem
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm,
                  n = n, ...)
  )
}

# internal function that swaps all distributions to *dist naming
mappingswap <- function(mapping, data){
  distcols <- names(data)[sapply(data, distributional::is_distribution)]
  distindex <- as.character(sapply(mapping, rlang::quo_get_expr)) %in% distcols
  new_mapping <- mapping
  names(new_mapping)[distindex] <-  paste(names(new_mapping),"dist", sep="")[distindex]
  new_mapping
}


