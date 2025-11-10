#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' 
#' @export
position_dodge_identity <- function(width = NULL, preserve = "total", orientation = "x",
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
                                            # split into groups
                                            g <- data$drawID
                                            groups <- split(data, g)
                                            
                                            new_data <- lapply(groups, function(group){
                                              new <- ggproto_parent(PositionDodge, self)$setup_data(group, params)
                                              rownames(new) <- rownames(group)
                                              new
                                            }) 
                                            new_data <- unsplit(new_data, g)
                                            new_data
                                          },
                                          compute_panel = function(self, data, params, scales) {
                                           g <- data$drawID
                                           groups <- split(data, g)
                                           new_data <- lapply(groups, function(group){
                                             new <- ggproto_parent(PositionDodge, self)$compute_panel(group, params, scales)
                                             rownames(new) <- rownames(group)
                                             new
                                           }) 
                                           
                                           new_data <- unsplit(new_data, g)
                                           # print("Original data")
                                           # print(table(data$x))
                                           # print("transformed data")
                                           # print(table(new_data$x))
                                           new_data
                                         },
                                         
                                       extra_params = c("vjust", "reverse")
)