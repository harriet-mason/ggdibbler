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