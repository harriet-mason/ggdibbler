#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' 
#' @export
position_stack_identity <- function(vjust = 1, reverse = FALSE) {
  ggproto(PositionStackIdentity, ggplot2::PositionStack, vjust = vjust, reverse = reverse)
}

data_check <- function(data){
  print(tibble::as_tibble(data))
  #data
}

#' @rdname position_stack_identity
#' @format NULL
#' @usage NULL
#' @export
PositionStackIdentity <- ggplot2::ggproto("PositionStackIdentity", ggplot2::PositionIdentity,
                              type = NULL,
                              vjust = 1,
                              fill = FALSE,
                              reverse = FALSE,
                              
                              compute_panel = function(self, data, params, scales) {
                                g <- data$drawID
                                groups <- split(data, g)
                                new_data <- lapply(groups, function(group){
                                  new <- PositionStack$compute_panel(group, params, scales)
                                  #new <- ggproto_parent(PositionStack, self)$compute_panel(group, params, scales)
                                  rownames(new) <- rownames(group)
                                  new
                                  }) 
                                
                                new_data <- unsplit(new_data, g)
                                new_data
                                },
                              
                              extra_params = c("vjust", "reverse")
)
