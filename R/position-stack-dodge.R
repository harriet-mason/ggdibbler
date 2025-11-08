#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' 
#' @export
position_stack_dodge <- function(vjust = 1, reverse = FALSE) {
  ggproto(PositionStackDodge, PositionStack, vjust = vjust, reverse = reverse)
}

#' @rdname position_identity_subdivide
#' @format NULL
#' @usage NULL
#' @export
PositionStackDodge <- ggproto("PositionStackDodge", PositionStack,
                              type = NULL,
                              vjust = 1,
                              fill = FALSE,
                              reverse = FALSE,
                              
                              compute_panel = function(self, data, params, scales) {
                                print(params)
                                print(tibble::as_tibble(data))
                                new_data <- data |>
                                  dplyr::group_by(drawID,x, fill, group)|>
                                  ggproto_parent(PositionStack, self)$compute_panel(params, scales)
                                print(tibble::as_tibble(new_data))
                                new_data
                                },
                              
                              extra_params = c("vjust", "reverse")
)