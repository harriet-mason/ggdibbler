
#' @importFrom ggplot2 ggproto StatSum self
#' @rdname Stat
#' @format NULL
#' @usage NULL
#' @export
StatSumSample <- ggplot2::ggproto("StatSumSample", ggplot2::StatSum,
                         setup_data = function(data, params) {
                           sample_expand(data, params$times)
                           },
                         compute_panel = function(self, data, scales, times) {
                           draws <- split(data, data$drawID)
                           stats <- lapply(draws, function(draw){
                             new_data <- ggproto_parent(StatSum, self)$compute_panel(data, scales)
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
                           }, stats, groups, SIMPLIFY = FALSE)
                           
                           
                           non_constant_columns <- unique0(non_constant_columns)
                           
                           # We are going to drop columns that are not constant within groups and not
                           # carried over/recreated by the stat. This can produce unexpected results,
                           # and hence we warn about it (variables in dropped_aes are expected so
                           # ignored here).
                           dropped <- non_constant_columns[!non_constant_columns %in% self$dropped_aes]
                           if (length(dropped) > 0) {
                             cli::cli_warn(c(
                               "The following aesthetics were dropped during statistical transformation: {.field {dropped}}.",
                               "i" = "This can happen when ggplot fails to infer the correct grouping structure in the data.",
                               "i" = "Did you forget to specify a {.code group} aesthetic or to convert a numerical variable into a factor?"
                             ))
                           }
                           # Finally, combine the results and drop columns that are not constant.
                           data_new <- vec_rbind0(!!!stats)
                           data_new <- data_new[, !names(data_new) %in% non_constant_columns, drop = FALSE]
                           
                        
                         }
                             
)

#' @export
#' @rdname geom_count
#' @inheritParams ggplot2::stat_sum
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
stat_sum_sample <- make_constructor(StatSumSample, geom = "point", times = 30)

