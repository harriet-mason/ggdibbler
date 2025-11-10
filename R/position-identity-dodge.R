#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' 
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
                                          setup_params = function(self, data){
                                            params <- ggproto_parent(PositionDodge, self)$setup_params(data)
                                            # set n to be times if preserve = "single"
                                            if(!is.null(params$n)){
                                              params$n <- max(as.numeric(data$drawID))
                                            }
                                            params
                                          },
                                          
                                          setup_data = function(self, data, params){
                                            # data fine here
                                            g <- data$ogroup
                                            groups <- split(data, g)
                                            new_data <- lapply(groups, function(group){
                                              #new <- PositionDodge$setup_data(group, params)
                                              new <- ggproto_parent(PositionDodge, self)$setup_data(group, params)
                                              rownames(new) <- rownames(group)
                                              new
                                            }) 
                                            new_data <- unsplit(new_data, g)
                                            new_data
                                          },
                                          compute_panel = function(self, data, params, scales) {
                                            #params[[2]]
                                            #data <- data |> dplyr::filter(xmax==5.45)
                                            g <- data$ogroup
                                            groups <- split(data, g)
                                            new_data <- lapply(groups, function(group){
                                              new <- ggproto_parent(PositionDodge, self)$compute_panel(group, params)
                                              rownames(new) <- rownames(group)
                                              new
                                            }) 
                                            
                                            new_data <- unsplit(new_data, g)
                                            new_data
                                          },
                                          
                                          extra_params = c("vjust", "reverse")
)

