# takes two positions and runs ggdibbler
#' @keywords internal
position_nest <- function(position){
  # break positions up into two characterr
  pos <- stringr::str_split_1(position, "_")
  # call PositionMainDist
  ggplot2::ggproto(NULL, PositionMainDist,
                   pos_main = pos[1], 
                   pos_sample = pos[2]
                   )
  
}

#' @rdname position_dodge_identity
#' @format NULL
#' @usage NULL
#' @export
PositionMainDist <- ggplot2::ggproto("PositionMainDist", ggplot2::Position,
                                     pos_main = "identity",
                                     pos_sample = "identity",
                                     
                                       
                                       setup_params = function(self,data){
                                         # set positions as params
                                         
                                         param1 <- position_dictionary_main(self$pos_main)$setup_params(data)
                                         param2 <- position_dictionary_sample(self$pos_sample)$setup_params(data)
                                         list(param1, param2)
                                       },
                                       
                                       setup_data = function(data, params, scales){
                                         data <- position_dictionary_main(self$pos_main)$setup_data(data, params[[1]])
                                         position_dictionary_sample(self$pos_sample)$setup_data(data, params[[2]])
                                       
                                         },
                                       compute_panel = function(self, data, params, scales) {
                                         data <- position_dictionary_main(self$pos_main)$compute_panel(data, params[[1]])
                                         position_dictionary_sample(self$pos_sample)$compute_panel(data, params[[1]])
                                       },
)



# takes in position as a character returns ggproto for first slice
#' @keywords internal
position_dictionary_main <- function(position){
  pos_dict <- list("identity" = PositionIdentity,
                   "dodge" = PositionDodgeIdentity,
                   "stack" = PositionStackIdentity,
                   "dodge2" = PositionDodge2Identity,
                   "jitter" = PositionJitterIdentity,
                   "jitterdodge" = PositionJitterdodgeIdentity,
                   "nudge" = PositionNudgeIdentity,
                   "stack" = PositionStackIdentity,
                   "fill" = PositionFillIdentity,
  )
  pos_dict[[which(names(pos_dict)==position)]]
}

# takes in position as a character returns ggproto for 2nd slice
position_dictionary_sample <- function(position){
  pos_dict <- list("identity" = PositionIdentity,
                   "dodge" = PositionIdentityDodge,
                   "stack" = PositionIdentityStack,
                   "dodge2" = PositionIdentityDodge2,
                   "jitter" = PositionIdentityJitter,
                   "jitterdodge" = PositionIdentityJitterdodge,
                   "nudge" = PositionIdentityNudge,
                   "stack" = PositionIdentityStack,
                   "fill" = PositionIdentityFill,
  )
  pos_dict[[which(names(pos_dict)==position)]]
}

#' @keywords internal
position_by_group <- function(data, group, f, ...){
  # ... for parameters passed to position
  g <- data[,group]
  groups <- split(data, g)
  new_data <- lapply(groups, function(lil_data){
     new <- f(lil_data, ...)
     rownames(new) <- rownames(lil_data)
     new
   }) 
  dat <- unsplit(new_data, g)
  dat
}



