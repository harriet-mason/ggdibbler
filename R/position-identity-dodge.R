#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' print("x")
#' @export
position_identity_dodge <- function(width = NULL, preserve = "single", orientation = "x",
                                    reverse = FALSE) {
  ggplot2:::check_bool(reverse)
  ggplot2::ggproto(NULL, PositionIdentityDodge,
          width = width,
          preserve = arg_match0(preserve, c("total", "single")),
          orientation = arg_match0(orientation, c("x", "y")),
          reverse = reverse
  )
}

#' @rdname position_identity_dodge
#' @format NULL
#' @usage NULL
#' @export
PositionIdentityDodge <- ggplot2::ggproto("PositionIdentityDodge", ggplot2::PositionDodge,
                                          width = NULL,
                                          preserve = "single",
                                          orientation = "x",
                                          reverse = NULL,
                                          
                                          default_aes = aes(order = NULL),
                                          setup_params = function(self, data){
                                            params <- ggproto_parent(PositionDodge, self)$setup_params(data)
                                            # set n to be times if preserve = "single"
                                            if(!is.null(params$n)){
                                              params$n <- max(as.numeric(data$drawID))
                                            }
                                            params
                                          },
                                          
                                          setup_data = function(self, data, params){
                                            position_by_group(data, "ogroup",
                                                              ggproto_parent(PositionDodge, self)$setup_data,
                                                              params)
                                          },
                                          compute_panel = function(self, data, params, scales) {
                                            # set order to be drawID due to order problem
                                            data$order <- as.integer(data$drawID)
                                            position_by_group(data, "ogroup",
                                                              ggproto_parent(PositionDodge, self)$compute_panel,
                                                              params)
                                          },
                                          
                                          extra_params = c("vjust", "reverse")
)

