# load libraries
library(tidyverse)
library(distributional)
set.seed(23102025)
######################################################## MPG DATA SET ####################################################
mpg <- ggplot2::mpg
mpg_dist <- ggplot2::mpg

# Categorical Variables
# manufacturer # model # trans # drv # fl # class
manufacturer_names <- unique(mpg_dist$manufacturer)
model_names <- unique(mpg_dist$model)
trans_names <- unique(mpg_dist$trans)
drv_names <- unique(mpg_dist$drv)
fl_names <- unique(mpg_dist$fl)
class_names <- unique(mpg_dist$class)

# Discrete variables (small)
cyl_vals <- unique(mpg$cyl)

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


prob_vals2 <- function(name, all_names){
  len <- length(all_names)
  x <- which(name==all_names)
  probs <- rep(0, len)
  probs[x] <- runif(1,0.9,1)
  for(i in seq(len)[-x]){
    probs[i] <- runif(1, 0, (1-sum(probs[x])))
  }
  probs/sum(probs)
}

uncertain_mpg <- mpg |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
# Categorical Variables: # manufacturer # model # trans # drv # fl # class
         manufacturer = dist_categorical(prob = list(prob_vals(manufacturer, manufacturer_names)),
                                         outcomes = list(manufacturer_names)),
         model = dist_categorical(prob = list(prob_vals(model, model_names)),
                                         outcomes = list(model_names)),
         trans = dist_categorical(prob = list(prob_vals(trans, trans_names)),
                                         outcomes = list(trans_names)),
         drv = dist_categorical(prob = list(prob_vals(drv, drv_names)),
                                         outcomes = list(drv_names)),
         fl = dist_categorical(prob = list(prob_vals(fl, fl_names)),
                                         outcomes = list(fl_names)),
         class = dist_categorical(prob = list(prob_vals(class, class_names)),
                               outcomes = list(class_names)),
# Continuous: # displ
         displ = dist_uniform(displ - runif(1, 0, 1), displ + runif(1, 0, 1)),
# Integer: # year # cyl # cty # hwy
         year = dist_sample(list(sample(seq(from=year-2, to = year+2), replace = TRUE))),
         cyl =  dist_categorical(prob = list(prob_vals2(cyl, cyl_vals)),
                                 outcomes = list(cyl_vals)),
         cty = dist_binomial(size = round(1+cty/0.9), prob=0.9),
         hwy = dist_binomial(size = round(1+hwy/0.99), prob=0.99)) |>
  ungroup() |>
  select(-id)

usethis::use_data(uncertain_mpg, overwrite = TRUE)




