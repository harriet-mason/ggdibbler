#' Nested stack positions
#' 
#' These functions use nested positioning for distributional data, where the
#' original plot has a stacked position. This allows you to set different 
#' position adjustments for the "main" and "distribution" parts of your plot.
#' 
#' @inheritParams ggplot2::position_identity
#' @importFrom ggplot2 ggproto PositionDodge Position
#' @examples
#' # Standard ggplots often have a position adjustment to fix overplotting
#' # plot with overplotting
#' library(ggplot2)
#' ggplot(mpg, aes(class)) + 
#'   geom_bar(aes(fill = drv), alpha=0.5,
#'            position = "stack")
#' 
#' # but when we use this in ggdibbler, it can not work the way we expect
#' # normal stack warps the scale and doesn't communicate useful info
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "stack")
#' 
#' # nested positions allows us to differentiate which postion adjustments
#' # are used for the plot groups vs the distribution samples
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "stack_identity", alpha=0.2)
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "stack_dodge")
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

#' @rdname position_stack_identity
#' @export
position_stack_dodge <- function(vjust = 1, reverse = FALSE, width = NULL,  
                                 preserve = "single", orientation = "x") {
  PositionStackDodge
}

#' @rdname position_stack_identity
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
                                         param1 <- PositionStackIdentity$setup_params(data)
                                         param2 <- PositionIdentityDodge$setup_params(data)
                                         list(param1, param2)
                                       },
                                       
                                       setup_data = function(data, params, scales){
                                         data <- PositionIdentityDodge$setup_data(data, params[[2]])
                                         PositionStackIdentity$setup_data(data, params[[1]])
                                       },
                                       compute_panel = function(self, data, params, scales) {
                                         data <- PositionIdentityDodge$compute_panel(data, params[[2]])
                                         data <- PositionStackIdentity$compute_panel(data, params[[1]])
                                         data
                                       },
                                       
                                       extra_params = c("vjust", "reverse")
)