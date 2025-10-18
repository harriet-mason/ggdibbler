
#' @export
StatDensitySample <- ggproto("StatDensitySample", ggplot2::StatDensity,
 
                             setup_data = function(data, params) {
                               set_data <- sample_expand(data, params$times)
                               print(set_data)
                               set_data
                               
                               
                             },
                             compute_group = function(self, data, scales, times, bw = "nrd0", adjust = 1, kernel = "gaussian",
                                                      n = 512, trim = FALSE, na.rm = FALSE, bounds = c(-Inf, Inf),
                                                      flipped_aes = FALSE, ...) {
                               #print(scales)

                               #stats <- ggproto_parent(StatDensity, self)$compute_group(data, scales, bw = "nrd0", adjust = 1, kernel = "gaussian",
                              #                                                 n = 512, trim = trim, na.rm = FALSE, bounds = c(-Inf, Inf),
                              #                                                 flipped_aes = FALSE, ...)
                               draws <- split(data, data$drawID)
                               stats <- lapply(draws, function(draw){
                                 new_data <- ggproto_parent(StatDensity, self)$compute_group(data = draw, scales = scales, bw = bw, adjust = adjust, 
                                                                                 kernel = kernel, n = n, trim = trim, na.rm = na.rm, bounds = bounds,
                                                                                 flipped_aes = flipped_aes, ...)
                                 }
                               )
                               # Record columns that are not constant within groups. We will drop them later.
                               non_constant_columns <- character(0)
                               
                               stats <- mapply(function(new, old) {
                                 # In this function,
                                 #
                                 #   - `new` is the computed result. All the variables will be picked.
                                 #   - `old` is the original data. There are 3 types of variables:
                                 #     1) If the variable is already included in `new`, it's ignored
                                 #        because the values of `new` will be used.
                                 #     2) If the variable is not included in `new` and the value is
                                 #        constant within the group, it will be picked.
                                 #     3) If the variable is not included in `new` and the value is not
                                 #        constant within the group, it will be dropped. We need to record
                                 #        the dropped columns to drop it consistently later.
                                 
                                 if (empty(new)) return(data_frame0())
                                 
                                 # First, filter out the columns already included `new` (type 1).
                                 old <- old[, !(names(old) %in% names(new)), drop = FALSE]
                                 
                                 # Then, check whether the rest of the columns have constant values (type 2)
                                 # or not (type 3).
                                 non_constant <- vapply(old, vec_unique_count, integer(1)) > 1L
                                 
                                 # Record the non-constant columns.
                                 non_constant_columns <<- c(non_constant_columns, names(old)[non_constant])
                                 
                                 vec_cbind(
                                   new,
                                   # Note that, while the non-constant columns should be dropped, we don't
                                   # do this here because it can be filled by vec_rbind() later if either
                                   # one of the group has a constant value (see #4394 for the details).
                                   old[rep(1, nrow(new)), , drop = FALSE]
                                 )
                               }, stats, draws, SIMPLIFY = FALSE)
                               
                               non_constant_columns <- unique0(non_constant_columns)
                               
                               # We are going to drop columns that are not constant within groups and not
                               # carried over/recreated by the stat. This can produce unexpected results,
                               # and hence we warn about it (variables in dropped_aes are expected so
                               # ignored here).
                               dropped <- non_constant_columns[!non_constant_columns %in% self$dropped_aes]
                               
                               # Finally, combine the results and drop columns that are not constant.
                               data_new <- vec_rbind0(!!!stats)
                               data_new[, !names(data_new) %in% non_constant_columns, drop = FALSE]
                               
                               # Not getting to this code at all
                               print("check")
                               print(data_new)
                               data_new
                             }
                             )
                             
            


#' Visualise Densities with Uncertainty
#' 
#' Identical to geom_sf, except that the fill for each area will be a distribution. 
#' This function will replace the fill area with a grid, where each cell is filled with an outcome from the fill distribution. 
#' 
#' @importFrom ggplot2 aes layer
#' @importFrom rlang list2
#' @param times A parameter used to control the number of samples
#' @returns A ggplot2 geom representing a density sample which can be added to a ggplot object
#' @inheritParams ggplot2::geom_density
#' @export
stat_density_sample <- function(mapping = NULL, data = NULL, geom = "density",
                                position = "stack", ..., na.rm = FALSE, 
                                show.legend = NA, inherit.aes = TRUE, times = 30) {
    ggplot2::layer(
      stat = StatDensitySample, 
      data = data, 
      mapping = mapping, 
      geom = geom, 
      position = position, 
      show.legend = show.legend, 
      inherit.aes = inherit.aes, 
      params = list(times = times, ...)
    )
}
  