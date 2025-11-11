#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' print("x")
#' @export
position_dodge_dodge <- function(vjust = 1, reverse = FALSE, width = NULL,  
                                 preserve = "single", orientation = "x") {
  PositionDodgeDodge
}

#' @rdname position_dodge_dodge
#' @format NULL
#' @usage NULL
#' @export
PositionDodgeDodge <- ggplot2::ggproto("PositionDodgeDodge", ggplot2::Position,
                                       type = NULL,
                                       vjust = 1,
                                       fill = FALSE,
                                       width = NULL,
                                       preserve = "single",
                                       orientation = "x",
                                       reverse = NULL,
                                       default_aes = aes(order = NULL),
                                       
                                       setup_params = function(self,data){
                                         param2 <- PositionDodgeIdentity$setup_params(data)
                                         param1 <- PositionIdentityDodge$setup_params(data)
                                         
                                         # cant use self for single argument
                                         if (identical(self$preserve, "single")){
                                           #print()
                                           #param2$n <- max(as.numeric(data$drawID))
                                         }
                                         list(param1, param2)
                                       },
                                       
                                       setup_data = function(data, params, scales){
                                         data <- PositionDodgeIdentity$setup_data(data, params[[2]])
                                       },
                                       compute_panel = function(self, data, params, scales) {
                                         data <- PositionDodgeIdentity$compute_panel(data, params[[2]])
                                         data <- PositionIdentityDodge$compute_panel(data, params[[1]])
                                         data
                                       },
                                       
                                       extra_params = c("vjust", "reverse")
)