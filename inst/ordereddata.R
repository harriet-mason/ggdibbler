# load libraries
<<<<<<< HEAD
library(ggdibbler)
library(ggplot2)
library(dplyr)

# make data smaller because otherwise there is no uncertainty
index <- sample(nrow(uncertain_diamonds), size = 1000)
smaller_diamonds <- diamonds[index,]

# get unique values for ordered stat
cut_names <- unique(smaller_diamonds$cut)
clarity_names <- unique(smaller_diamonds$clarity)

# function that gets probability
prob_vals <- function(name, all_names){
  len <- length(all_names)
  x <- which(name==all_names)
  probs <- rep(0, len)
  probs[x] <- runif(1,0.7,0.9)
  for(i in seq(len)[-x]){
    probs[i] <- runif(1, 0, (1-sum(probs[x])))
  }
  probs/sum(probs)
}

# Make uncertain data
new_uncertain_diamonds <- smaller_diamonds |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
    cut = dist_categorical(prob = list(prob_vals(cut, cut_names)),
                           outcomes = list(cut_names)),
    clarity = dist_categorical(prob = list(prob_vals(clarity, clarity_names)),
                               outcomes = list(clarity_names))
  )


ggplot(new_uncertain_diamonds, aes(x = cut, y = clarity)) +
  geom_count_sample(aes(size = after_stat(prop)), alpha=0.1, times=10, group = 1) +
  scale_size_area(max_size = 10)

=======
#library(ggdibbler)
library(ggplot2)
library(distributional)

# make data smaller because otherwise there is no uncertainty
index <- sample(nrow(uncertain_diamonds), size = 100)
smaller_diamonds <- diamonds[index,]
smaller_uncertain_diamonds <- uncertain_diamonds[index,]

# GROUP EFFECT IS SWAPPED, PROBABLY BECAUSE I ADD THE GROUPS IN, 
# CHECK HOW GGPLOT DOES IT
>>>>>>> dev
# ggplot example
ggplot(smaller_diamonds, aes(x = cut, y = clarity)) +
  geom_count(aes(size = after_stat(prop), group = 1)) +
  scale_size_area(max_size = 10)

<<<<<<< HEAD
# ggdibbler example
ggplot(smaller_uncertain_diamonds, aes(x = cut, y = clarity)) +
  geom_count_sample(aes(size = after_stat(prop)), alpha=0.2, times=10) +
  scale_size_area(max_size = 10)
=======
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
>>>>>>> dev
