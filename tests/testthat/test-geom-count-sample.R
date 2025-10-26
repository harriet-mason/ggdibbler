
# THIS CODE FROM EXAMPLE RETURNS ERROR 
# LIKELY DUE TO CATEGORICAL MAPPED TO POSITION
# GGPLOT
p <- ggplot(diamonds, aes(x = cut, y = clarity))
p + geom_count_sample(aes(size = after_stat(prop)))
p + geom_count(aes(size = after_stat(prop), group = 1)) +
  scale_size_area(max_size = 10)
# GGDIBBLER
smaller_diamonds <- uncertain_diamonds[sample(nrow(uncertain_diamonds), size = 1000),]
q <- ggplot(smaller_diamonds, aes(x = cut, y = clarity))
# q + geom_count_sample(aes(size = after_stat(prop)), times=10, alpha=0.1)

ggplot(data = uncertain_mtcars, aes(x=wt, y=mpg, distshape=cyl)) +
  geom_point_sample(aes(shape = factor(after_stat(distshape))))
ggplot(smaller_diamonds, aes(xdist = cut, ydist = clarity)) +
  geom_count_sample(aes(x = factor(after_stat(xdist),
                                   levels = levels(diamonds$cut)),
                        y = factor(after_stat(ydist),
                                   levels = levels(diamonds$clarity)),
                        size = after_stat(prop), group = 1), alpha=0.1)
  


geom_count_sample(aes(size = after_stat(prop), group = 1),alpha=0.1) +
  scale_size_area(max_size = 10)
p + geom_count(aes(size = after_stat(prop), group = 1)) +
  scale_size_area(max_size = 10)

# CHECK DISTS
new_diamonds <- diamonds[diamond_ind,]

ind <- sample(nrow(uncertain_diamonds), size = 3)
test1 <- uncertain_diamonds[ind,c("cut", "clarity")]
test2 <- new_diamonds[ind,c("cut", "clarity")]
generate(test1$cut, 5)
test2$cut
generate(test1$clarity, 5)
test2$clarity

as.integer(unique(diamonds$cut))
