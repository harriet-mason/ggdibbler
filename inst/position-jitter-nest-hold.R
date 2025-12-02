
#' @inheritParams ggplot2::position_jitter
#' @rdname position_identity_identity
#' @format NULL
#' @usage NULL
#' @export
position_identity_jitter <- function(width = NULL, height = NULL, seed = NA) {
  ggproto(NULL, PositionJitter,
          width = width,
          height = height,
          seed = seed
  )
}

#' @inheritParams ggplot2::PositionJitter
#' @rdname position_identity_identity
#' @format NULL
#' @usage NULL
#' @export
PositionIdentityJitter <- ggplot2::ggproto("PositionIdentityJitter", ggplot2::PositionJitter,
                                           seed = NA,
                                           required_aes = c("x", "y"),
                                           
                                           setup_params = function(self, data){
                                             # split into groups
                                             if(!("ogroup" %in% names(data))){
                                               ggproto_parent(PositionJitter, self)$setup_params
                                             } else{
                                               position_by_group(data, "ogroup",
                                                                 ggproto_parent(PositionJitter, self)$setup_params)
                                             }
                                           },
                                           
                                           
                                           compute_panel = function(self, data, params, scales){
                                             print(names(data))
                                             if(!("ogroup" %in% names(data))){
                                               ggproto_parent(PositionJitter, self)$compute_panel(self, 
                                                                                                  data, 
                                                                                                  params, 
                                                                                                  scales)
                                               
                                             } else{
                                               position_by_group(data, "ogroup", ggproto_parent(PositionJitter, 
                                                                                                self)$compute_panel(self, 
                                                                                                                    data, 
                                                                                                                    params, 
                                                                                                                    scales))
                                             }
                                           },
                                           
                                           extra_params = c("vjust", "reverse")
)
