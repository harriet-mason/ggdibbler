#' @keywords internal
position_by_group <- function(data, group, f, ...){
  # ... for parameters passed to position
  g <- data[,group]
  groups <- split(data, g)
  new_data <- lapply(groups, function(lil_data){
     new <- f(lil_data, ...)
     rownames(new) <- rownames(lil_data)
     new
   }) 
  dat <- unsplit(new_data, g)
  dat
}



