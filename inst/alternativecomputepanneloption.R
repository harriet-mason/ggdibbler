compute_panel = function(self, data, scales, times) {
  draws <- split(data, data$drawID)
  stats <- lapply(draws, function(draw){
    new_data <- ggproto_parent(StatSum, self)$compute_panel(data, scales)
  })
  stats <- mapply(map_func, stats, draws, SIMPLIFY = FALSE)
  
  data_new <- vctrs::vec_rbind(!!!stats)
  data_new
  
  ggproto_parent(StatSum, self)$compute_panel(data, scales)
}

map_func <- function(new, old) {
  if (empty(new)) return(data_frame0())
  # First, filter out the columns already included `new` (type 1).
  old <- old[, !(names(old) %in% names(new)), drop = FALSE]
  vctrs::vec_cbind(new, old[rep(1, nrow(new)), , drop = FALSE])
}

# Wrapping unique0() to accept NULL
unique0 <- function(x, ...) if (is.null(x)) x else vctrs::vec_unique(x, ...)

empty <- function(df) {
  is.null(df) || nrow(df) == 0 || ncol(df) == 0 || is_waiver(df)
}