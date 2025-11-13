#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' print("x")
#' @export
position_identity_stack <- function(vjust = 1, reverse = FALSE) {
  ggproto(NULL, PositionIdentityStack, vjust = vjust, reverse = reverse)
}


#' @rdname position_identity_stack
#' @format NULL
#' @usage NULL
#' @export
PositionIdentityStack <- ggplot2::ggproto("PositionIdentityStack", ggplot2::PositionStack,
                                          type = NULL,
                                          vjust = 1,
                                          fill = FALSE,
                                          reverse = FALSE,
                                          setup_data = function(self, data, params){
                                            # split into groups
                                            position_by_group(data, "ogroup",
                                                              ggproto_parent(PositionStack, self)$setup_data,
                                                              params)
                                          },
                                          
                                          
                                          compute_panel = function(self, data, params, scales){
                                            position_by_group(data, "ogroup",
                                                              ggproto_parent(PositionStack, self)$setup_data,
                                                              params)
                                          },
                                          
                                          extra_params = c("vjust", "reverse")
)
