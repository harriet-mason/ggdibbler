# Define variables to stop CRAN checks from having a big ol' whinge
utils::globalVariables(c("geometry", "drawID", "fill", "unit", "x", "y",
                         "group", "PANEL", "L1", "L2", "ungroup", "ogroup",
                         "select", "cur_group_id", "geometryID"))

##################### THINGS I HAD TO STEAL FROM GGPLOT ############


# ggplot2:::ggplot_global
ggplot_global <- list(
  x_aes = c(
    "x",
    "xmin",
    "xmax",
    "xend",
    "xintercept",
    "xmin_final",
    "xmax_final",
    "xlower",
    "xmiddle",
    "xupper",
    "x0"
  ),
  y_aes = c(
    "y",
    "ymin",
    "ymax",
    "yend",
    "yintercept",
    "ymin_final",
    "ymax_final",
    "lower",
    "middle",
    "upper",
    "y0"
  )
)

.standalone_types_check_dot_call <- .Call

check_bool <- function(x,
                       ...,
                       allow_na = FALSE,
                       allow_null = FALSE,
                       arg = caller_arg(x),
                       call = caller_env()) {
  if (!missing(x) && .standalone_types_check_dot_call(ffi_standalone_is_bool_1.0.7, x, allow_na, allow_null)) {
    return(invisible(NULL))
  }
  
  stop_input_type(
    x,
    c("`TRUE`", "`FALSE`"),
    ...,
    allow_na = allow_na,
    allow_null = allow_null,
    arg = arg,
    call = call
  )
}

check_number_decimal <- function(x,
                                 ...,
                                 min = NULL,
                                 max = NULL,
                                 allow_infinite = TRUE,
                                 allow_na = FALSE,
                                 allow_null = FALSE,
                                 arg = caller_arg(x),
                                 call = caller_env()) {
  if (missing(x)) {
    exit_code <- IS_NUMBER_false
  } else if (0 == (exit_code <- .standalone_types_check_dot_call(
    ffi_standalone_check_number_1.0.7,
    x,
    allow_decimal = TRUE,
    min,
    max,
    allow_infinite,
    allow_na,
    allow_null
  ))) {
    return(invisible(NULL))
  }
  
  .stop_not_number(
    x,
    ...,
    exit_code = exit_code,
    allow_decimal = TRUE,
    min = min,
    max = max,
    allow_na = allow_na,
    allow_null = allow_null,
    arg = arg,
    call = call
  )
}

is_mapped_discrete <- function(x) inherits(x, "mapped_discrete")

##### STOLEN FROM SCALES PACKAGE
discrete_range <- function(old, new, drop = FALSE, na.rm = FALSE, fct = NA) {
  new_is_factor <- is.factor(new)
  old_is_factor <- is.factor(old) || isTRUE(fct)
  new <- clevels(new, drop = drop, na.rm = na.rm)
  if (is.null(old)) {
    return(new)
  }
  
  if (old_is_factor && !is.factor(old)) {
    old <- factor(old, old)
  }
  if (!is.character(old)) {
    old <- clevels(old, na.rm = na.rm)
  } else {
    old <- sort(old, na.last = if (na.rm) NA else TRUE)
  }
  
  # If new is more rich than old it becomes the primary
  if (new_is_factor && !old_is_factor) {
    tmp <- old
    old <- new
    new <- tmp
    tmp <- old_is_factor
    old_is_factor <- new_is_factor
    new_is_factor <- tmp
  }
  
  new_levels <- setdiff(new, old)
  
  # Keep as a factor if we don't have any new levels
  if (length(new_levels) == 0) {
    return(old)
  }
  
  range <- c(old, new_levels)
  
  # Avoid sorting levels when dealing with factors. `old` will always be a
  # factor if either `new` or `old` was a factor going in
  if (old_is_factor) {
    return(range)
  }
  sort(range, na.last = if (na.rm) NA else TRUE)
}

clevels <- function(x, drop = FALSE, na.rm = FALSE) {
  if (is.null(x)) {
    character()
  } else if (!is.null(levels(x))) {
    if (drop && !is.character(x)) x <- droplevels(x)
    
    values <- levels(x)
    if (na.rm) {
      values <- values[!is.na(values)]
    } else if (any(is.na(x))) {
      values <- c(values, NA)
    }
    
    values
  } else {
    sort(unique(x), na.last = if (na.rm) NA else TRUE)
  }
}