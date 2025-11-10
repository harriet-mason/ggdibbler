#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' 
#' @export
position_stack_dodge <- function(vjust = 1, reverse = FALSE, width = NULL,  
                                 preserve = "single", orientation = "x") {
  PositionStackDodge
}

#' @rdname position_stack_dodge
#' @format NULL
#' @usage NULL
#' @export
PositionStackDodge <- ggplot2::ggproto("PositionStackDodge", ggplot2::Position,
                                       type = NULL,
                                       vjust = 1,
                                       fill = FALSE,
                                       width = NULL,
                                       preserve = "single",
                                       orientation = "x",
                                       reverse = NULL,
                                       default_aes = aes(order = NULL),
                                       
                                       setup_params = function(self,data){
                                         data <- data |> dplyr::filter(xmax==5.45)
                                         
                                         param1 <- PositionStackIdentity$setup_params(data)
                                         
                                         param2 <- PositionIdentityDodge$setup_params(data)
                                         # cant use self for single argument
                                         if (identical(self$preserve, "single")){
                                           param2$n <- max(as.numeric(data$drawID))
                                         }
                                         list(param1, param2)
                                       },
                                       
                                       setup_data = function(data, params, scales){
                                         data <- data |> dplyr::filter(xmax==5.45) #|>
                                           #dplyr::filter(drawID == "2")
                                         data <- PositionIdentityDodge$setup_data(data, params[[2]])
                                         PositionStackIdentity$setup_data(data, params[[1]])
                                       },
                                       compute_panel = function(self, data, params, scales) {
                                         data <- PositionIdentityDodge$compute_panel(data, params[[2]])
                                         #print(tibble::as_tibble(data))
                                         #print(table(data$xmax))
                                         #print(table(data$ymin==0))
                                         #print(table(data$order))
                                         data <- PositionStackIdentity$compute_panel(data, params[[1]])
                                         #print(tibble::as_tibble(data))
                                         #print(table(data$xmax))
                                         #print(table(data$ymin==0))
                                         #print(table(data$order))
                                         
                                       },
                                       
                                       extra_params = c("vjust", "reverse")
)