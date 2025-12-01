#' Nested dodge positions
#' 
#' These functions use nested positioning for distributional data, where the
#' original plot has a dodged position. This allows you to set different 
#' position adjustments for the "main" and "distribution" parts of your plot.
#' 
#' @inheritParams ggplot2::position_dodge
#' @inheritParams ggplot2::position_identity
#' @aesthetics PositionDodge
#' @importFrom ggplot2 ggproto PositionDodge Position
#' @examples
#' # Standard ggplots often have a position adjustment to fix overplotting
#' # plot with dodged positions
#' library(ggplot2)
#' ggplot(mpg, aes(class)) + 
#'   geom_bar(aes(fill = drv), 
#'            position = position_dodge(preserve = "single"))
#' 
#' # but when we use this in ggdibbler, it can not work the way we expect
#' # normal dodge
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "dodge")
#' 
#' # nested positions allows us to differentiate which postion adjustments
#' # are used for the plot groups vs the distribution samples
#' 
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "dodge_identity", alpha=0.2)
#' 
#' # using postion_dodge nests the original plot group inside the distribtion 
#' # position dodge_dodge does the opposite nesting
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "dodge_dodge")
#'   
#' @rdname position_dodge_identity
#' @export
position_dodge_dodge <- function(width = NULL, preserve = "single", orientation = "x",
                                 reverse = FALSE) {
  PositionDodgeDodge
}
#' @rdname position_dodge_identity
#' @export
position_dodge_identity <- function(width = NULL, preserve = "single", orientation = "x",
                                    reverse = FALSE) {
  ggproto(NULL, PositionDodgeIdentity,
          width = width,
          preserve = arg_match0(preserve, c("total", "single")),
          orientation = arg_match0(orientation, c("x", "y")),
          reverse = reverse
  )
}


#' @rdname position_dodge_identity
#' @format NULL
#' @usage NULL
#' @export
PositionDodgeIdentity <- ggplot2::ggproto("PositionDodgeIdentity", ggplot2::PositionDodge,
                                          width = NULL,
                                          preserve = "single",
                                          orientation = "x",
                                          reverse = NULL,
                                          default_aes = aes(order = NULL),
                                          
                                          setup_params = function(self, data){
                                            # get params from setup params
                                            params <- ggproto_parent(PositionDodge, self)$setup_params(data)
                                            
                                            # edit params if n has been set
                                            if(!is.null(params$n)){
                                              times <- max(as.numeric(data$drawID))
                                              params$n <- params$n/times
                                            }
                                            # return params
                                            params
                                          },
                                          
                                          setup_data = function(self, data, params){
                                            position_by_group(data, "drawID",
                                                              ggproto_parent(PositionDodge, self)$setup_data,
                                                              params)
                                          },
                                          compute_panel = function(self, data, params, scales) {
                                            # correct order before positioning by group
                                            # make position consistent between draws
                                            if(!is.null(params$n)){ #if preserve = single
                                              data$order <- 1 + ((data$ogroup + params$n - 1) %% params$n)
                                            }
                                            position_by_group(data, "drawID",
                                                              ggproto_parent(PositionDodge, self)$compute_panel,
                                                              params)
                                          },
                                          
                                          extra_params = c("vjust", "reverse")
)


#' @inheritParams ggplot2::position_dodge
#' @rdname position_identity_identity
#' @export
position_identity_dodge <- function(width = NULL, preserve = "single", 
                                    orientation = "x", reverse = FALSE) {
  ggplot2::ggproto(NULL, PositionIdentityDodge,
                   width = width,
                   preserve = arg_match0(preserve, c("total", "single")),
                   orientation = arg_match0(orientation, c("x", "y")),
                   reverse = reverse
  )
}

#' @inheritParams ggplot2::position_dodge
#' @rdname position_identity_identity
#' @format NULL
#' @usage NULL
#' @export
PositionIdentityDodge <- ggplot2::ggproto("PositionIdentityDodge", 
                                          ggplot2::PositionDodge,
                                          width = NULL,
                                          preserve = "single",
                                          orientation = "x",
                                          reverse = NULL,
                                          
                                          default_aes = aes(order = NULL),
                                          setup_params = function(self, data){
                                            params <- ggproto_parent(PositionDodge, 
                                                                     self)$setup_params(data)
                                            # set n to be times if preserve = "single"
                                            if(!is.null(params$n)){
                                              params$n <- max(as.numeric(data$drawID))
                                            }
                                            params
                                          },
                                          
                                          setup_data = function(self, data, params){
                                            position_by_group(data, "ogroup",
                                                              ggproto_parent(PositionDodge, 
                                                                             self)$setup_data,
                                                              params)
                                          },
                                          compute_panel = function(self, data, 
                                                                   params, scales) {
                                            # set order to be drawID due to order problem
                                            data$order <- as.integer(data$drawID)
                                            position_by_group(data, "ogroup",
                                                              ggproto_parent(PositionDodge, 
                                                                             self)$compute_panel,
                                                              params)
                                          },
                                          
                                          extra_params = c("vjust", "reverse")
)

#' @rdname position_dodge_identity
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