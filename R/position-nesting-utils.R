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


# takes in position as a character returns ggproto for first slice
#' @keywords internal
position_dictionary_main <- function(position){
  pos_dict <- list("identity" = PositionIdentity,
                   "dodge" = PositionDodgeIdentity,
                   "stack" = PositionStackIdentity #,
                   # "dodge2" = PositionDodge2Identity,
                   # "jitter" = PositionJitterIdentity,
                   # "jitterdodge" = PositionJitterdodgeIdentity,
                   # "nudge" = PositionNudgeIdentity,
                   # "stack" = PositionStackIdentity,
                   # "fill" = PositionFillIdentity,
  )
  pos_dict[[which(names(pos_dict)==position)]]
}

# takes in position as a character returns ggproto for 2nd slice
position_dictionary_sample <- function(position){
  pos_dict <- list("identity" = PositionIdentity,
                   "dodge" = PositionIdentityDodge,
                   "stack" = PositionIdentityStack #,
                   # "dodge2" = PositionIdentityDodge2,
                   # "jitter" = PositionIdentityJitter,
                   # "jitterdodge" = PositionIdentityJitterdodge,
                   # "nudge" = PositionIdentityNudge,
                   # "stack" = PositionIdentityStack,
                   # "fill" = PositionIdentityFill,
  )
  pos_dict[[which(names(pos_dict)==position)]]
}

#' @rdname position_dodge_identity
#' @format NULL
#' @usage NULL
#' @export
position_nest <- function(position = "identity_identity"){
  
  # call PositionMainDist
  ggplot2::ggproto(NULL, PositionNest,
                   position = position,
  )
}

#' @rdname position_nest
#' @format NULL
#' @usage NULL
#' @export
PositionNest <- ggplot2::ggproto("PositionNest", ggplot2::Position,
                                 position = "identity_identity",

                                 setup_params = function(self, data){
                                   # get positions out
                                   pos <- stringr::str_split_1(self$position, "_")
                                   # run setup params from each position
                                   param1 <- position_dictionary_main(pos[1])$setup_params(data)
                                   param2 <- position_dictionary_sample(pos[2])$setup_params(data)
                                   # return list of params
                                   list(param1, param2, pos)
                                 },
                                 
                                 setup_data = function(data, params, scales){
                                   data <- position_dictionary_main(params[[3]][1])$setup_data(data, params[[1]])
                                   position_dictionary_sample(params[[3]][2])$setup_data(data, params[[2]])
                                   
                                 },
                                 compute_panel = function(data, params, scales) {
                                   data <- position_dictionary_main(params[[3]][1])$compute_panel(data, params[[1]])
                                   position_dictionary_sample(params[[3]][2])$compute_panel(data, params[[2]])
                                 },
)





