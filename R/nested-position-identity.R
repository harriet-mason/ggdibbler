#' Nested identity positions
#' 
#' These functions use nested positioning for distributional data, where the
#' original plot has a position_identity argument. This allows
#' you to set different position adjustments for your "main plot" i.e. the
#' position adjustment you would have made in the version of the plot you are
#' signal supressing, and the "distribution" part of the plot, where the 
#' overplotting results from showing a set of outcomes where there was once
#' a single point. 
#' 
#' @inheritParams ggplot2::position_identity
#' @importFrom ggplot2 ggproto PositionDodge Position
#' @examples
#' # Standard ggplots often have a position adjustment to fix overplotting
#' # plot with overplotting
#' ggplot(mpg, aes(class)) + 
#'   geom_bar(aes(fill = drv), alpha=0.5,
#'            position = "identity")
#' 
#' # sometimes ggdibbler functions call for more control over these 
#' # overplotting adjustments
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "identity", alpha=0.1)
#' # is the same as...
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "identity_identity", alpha=0.1)
#'   
#' # nested positions allows us to differentiate which postion adjustments
#' # are used for the plot groups vs the distribution samples
#' ggplot(uncertain_mpg, aes(class)) + 
#'   geom_bar_sample(aes(fill = drv), position = "identity_dodge", alpha=0.7)
#' @export
position_identity_identity <- ggplot2::position_identity


#' @inheritParams ggplot2::position_dodge
#' @rdname position_identity_identity
#' @export
position_identity_dodge <- function(width = NULL, preserve = "single", 
                                    orientation = "x", reverse = FALSE) {
  ggplot2:::check_bool(reverse)
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
                                            #' set n to be times if preserve = "single"
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
                                            #' set order to be drawID due to order problem
                                            data$order <- as.integer(data$drawID)
                                            position_by_group(data, "ogroup",
                                                              ggproto_parent(PositionDodge, 
                                                                             self)$compute_panel,
                                                              params)
                                          },
                                          
                                          extra_params = c("vjust", "reverse")
)