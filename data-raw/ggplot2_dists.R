# load libraries
library(tidyverse)
library(distributional)

# make mpg_dist
mpg <- ggplot2::mpg
mpg_dist <- ggplot2::mpg

# Character Variables

# manufacturer # model # trans # drv # fl # class
manufacturer_names <- unique(mpg_dist$manufacturer)
model_names <- unique(mpg_dist$model)
trans_names <- unique(mpg_dist$trans)
drv_names <- unique(mpg_dist$drv)
fl_names <- unique(mpg_dist$fl)
class_names <- unique(mpg_dist$class)

# Convert them into dist_categorical
# function that takes name and returns a randomly generated prediction uncertainty
prob_vals <- function(name, all_names){
  lambda <- which(name==all_names)
  obs <- rpois(1000, lambda)
  len <- length(all_names)
  probs <- rep(0, len)
  for(i in seq(len)){
    probs[i] <- sum(obs == seq(len)[i])
  }
  probs/sum(probs)
}


prob_vals('audi',manufacturer_names)


plist <- prob_list(mpg$manufacturer, manufacturer_names)

mpg_dist$manufacturer <- mpg |>
  group_by(displ, model_names)
  mutate(manufacturer = dist_categorical(prob = prob_list(mpg$manufacturer, manufacturer_names),
                                         outcomes = list(manufacturer_names)))
df <- data.frame(
  id = 1:5,
  value = c(10, 15, 20, 25, 30)
)

df <- df %>%
  mutate(random_uniform = runif(n = n()))

# Add a new column 'random_normal' with random values from a normal distribution
# (mean 0, standard deviation 1 by default)
df_new_2 <- df %>%
  mutate(random_normal = rnorm(n = n()))
# Continuous
  # displ

# Integer
  # year 
  # cyl
  # cty
  # hwy




