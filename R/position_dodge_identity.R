#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' print("x")
#' @export
position_dodge_identity <- function(width = NULL, preserve = "single", orientation = "x",
                                      reverse = FALSE) {
  ggplot2:::check_bool(reverse)
  ggproto(NULL, PositionDodgeIdentity,
          width = width,
          preserve = arg_match0(preserve, c("total", "single")),
          orientation = arg_match0(orientation, c("x", "y")),
          reverse = reverse
  )
}

data_check <- function(data){
  print(tibble::as_tibble(data))
  #data
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
                                            print(self$preserve)
                                            position_by_group(data, "drawID",
                                                              ggproto_parent(PositionDodge, self)$compute_panel,
                                                              params)
                                         },
                                         
                                       extra_params = c("vjust", "reverse")
)