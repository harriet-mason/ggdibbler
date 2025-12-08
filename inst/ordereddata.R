# load libraries
#library(ggdibbler)
library(ggplot2)
library(distributional)

# make data smaller because otherwise there is no uncertainty
index <- sample(nrow(uncertain_diamonds), size = 100)
smaller_diamonds <- diamonds[index,]
smaller_uncertain_diamonds <- uncertain_diamonds[index,]

# GROUP EFFECT IS SWAPPED, PROBABLY BECAUSE I ADD THE GROUPS IN, 
# CHECK HOW GGPLOT DOES IT
# ggplot example
ggplot(smaller_diamonds, aes(x = cut, y = clarity)) +
  geom_count(aes(size = after_stat(prop), group = 1)) +
  scale_size_area(max_size = 10)

ggplot(smaller_diamonds, aes(x = cut, y = clarity)) +
  geom_count_sample(aes(size = after_stat(prop), group = 1)) +
  scale_size_area(max_size = 10)

ggplot(smaller_diamonds, aes(x = cut, y = clarity)) +
  geom_count_sample(aes(size = after_stat(prop)), alpha=0.2, times=100) +
  scale_size_area(max_size = 10)
# ggdibbler example
ggplot(smaller_uncertain_diamonds, aes(x = cut, y = clarity)) +
  geom_count_sample(aes(size = after_stat(prop)), group = 1, alpha=0.2, times=100) +
  scale_size_area(max_size = 10)

library(ggplot2)
#library(ggdibbler)
library(distributional)
ggplot(mtcars, 
       aes(sample = mpg, colour = factor(cyl))) +
  stat_qq() +
  stat_qq_line()


ggplot(uncertain_mtcars, 
       aes(sample = dist_transformed(cyl, ordered, as.numeric))) +
  stat_qq_sample() +
  stat_qq_line_sample()