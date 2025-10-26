if(family(dist) == "categorical"){
  dist <- list
}
old_params <- function(index){
  c("Fair","Good","Very Good","Premium","Ideal")[index]
}

new_params <- function(param){
  which(param == c("Fair","Good","Very Good","Premium","Ideal"))
}

new_dist <- dist_transformed(dist, new_params, identity)

dist
