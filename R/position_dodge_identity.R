#' TITLE
#' 
#' DESCRIPTION
#' 
#' @examples
#' 
#' @export
position_dodge_identity <- function(vjust = 1, reverse = FALSE) {
  ggproto(PositionDodgeIdentity, ggplot2::PositionDodge, vjust = vjust, reverse = reverse)
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
                                          setup_data = function(self, data, params){
                                            g <- data$drawID
                                            groups <- split(data, g)
                                            new_data <- lapply(groups, function(group){
                                              #new <- PositionDodge$compute_panel(group, params, scales)
                                              new <- ggproto_parent(PositionDodge, self)$setup_data(group, params)
                                              rownames(new) <- rownames(group)
                                              new
                                            }) 
                                            new_data <- unsplit(new_data, g)
                                            new_data
                                          },
                                          compute_panel = function(self, data, params, scales) {
                                            #print(data)
                                           #og_params <- params
                                           #print(params)
                                           g <- data$drawID
                                           groups <- split(data, g)
                                           #print(groups)
                                           new_data <- lapply(groups, function(group){
                                             #params <- og_params
                                             #print(params$width)
                                             #print("inside lapply 1")
                                             print(group)
                                             #new <- PositionDodge$compute_panel(group, params, scales)
                                             new <- ggproto_parent(PositionDodge, self)$compute_panel(group, params, scales)
                                             #print(params)
                                             rownames(new) <- rownames(group)
                                             #print("inside lapply 2")
                                             print(table(new$x))
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