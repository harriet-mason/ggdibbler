onedist <- smaller_uncertain_diamonds$cut[1]
generate(t_dist,5)

manydist <- smaller_uncertain_diamonds$cut[1:5]
tm_dist <- dist_transformed(manydist, disc_to_int, int_to_disc)
generate(tm_dist,5)

DIST_TRAN_ALTERNATIVE <- function(dist){
  # categorical integers
  if(unique(family(x)) == "categorical"){
    dist_param <- parameters(x)
    dist_categorical(prob = dist_param$p,
                     # outcomes = ggplot2::ggproto_parent(ggplot2::ScaleDiscretePosition, self)$map(dist_param$x)
                     outcomes = seq(length(dist_param$x)))
  } else if(unique(family(x)) == "sample") {
    dist_sample <- parameters(x)
  } else {
    dist
  }
}

# test for geoms
# make data smaller because otherwise there is no uncertainty
index <- sample(nrow(smaller_uncertain_diamonds), size = 100)
much_smaller_diamonds <- smaller_diamonds[index,]
much_smaller_uncertain_diamonds <- smaller_uncertain_diamonds[index,]

ggplot(much_smaller_diamonds, aes(x = cut, y = clarity)) +
  geom_count(aes(size = after_stat(prop), group = 1)) 

ggplot(much_smaller_uncertain_diamonds, aes(x = cut, y = clarity))  +
  geom_count_sample(aes(size = after_stat(prop), group = 1), alpha=0.1, times=20) 


