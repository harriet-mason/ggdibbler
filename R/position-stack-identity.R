#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' print("x")
#' @export
position_stack_identity <- function(vjust = 1, reverse = FALSE) {
  ggproto(NULL, PositionStackIdentity, vjust = vjust, reverse = reverse)
}


#' @rdname position_stack_identity
#' @format NULL
#' @usage NULL
#' @export
PositionStackIdentity <- ggplot2::ggproto("PositionStackIdentity", ggplot2::PositionStack,
                              type = NULL,
                              vjust = 1,
                              fill = FALSE,
                              reverse = FALSE,
                              setup_data = function(self, data, params){
                                # split into groups
                                position_by_group(data, "drawID",
                                                  ggproto_parent(PositionStack, self)$setup_data,
                                                  params)
                              },
                              
                              
                              compute_panel = function(self, data, params, scales){
                                position_by_group(data, "drawID",
                                                  ggproto_parent(PositionStack, self)$compute_panel,
                                                  params)
                                },
                              
                              extra_params = c("vjust", "reverse")
)