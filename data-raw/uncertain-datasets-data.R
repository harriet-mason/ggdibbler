#################################################### MTCARS DATA SET ##################################################
# library
library(tidyverse)
library(distributional)

# set seed because of all the random number generation
set.seed(24102025)

# datasets is built in
uncertain_mtcars <- mtcars

# Discrete variables (small)
cyl_vals <- unique(mtcars$cyl)
gear_vals <- unique(mtcars$gear)
carb_vals <- unique(mtcars$carb)

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
  probs[x] <- runif(1,0.7,0.9)
  for(i in seq(len)[-x]){
    probs[i] <- runif(1, 0, (1-sum(probs[x])))
  }
  probs/sum(probs)
}

uncertain_mtcars <- mtcars |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
    mpg = dist_uniform(mpg - runif(1, 0, 1.5), mpg + runif(1, 0, 1.5)),
    cyl =  dist_categorical(prob = list(prob_vals2(cyl, cyl_vals)),
                            outcomes = list(cyl_vals)),
    disp = dist_uniform(disp - runif(1, 0, 3), disp + runif(1, 0, 3)),
    hp = dist_normal(hp, runif(1, 0, 3)),
    drat = dist_uniform(drat - runif(1, 0, 0.3), drat + runif(1, 0, 0.3)),
    wt = dist_uniform(wt - runif(1, 0, 0.25), wt + runif(1, 0, 0.25)),
    qsec = dist_uniform(qsec - runif(1, 0, 1), qsec + runif(1, 0, 1)),
    vs = dist_binomial(1,prob = (0.9-0.8*vs)+runif(1, 0, 0.1)),
    am = dist_binomial(1,prob = (0.9-0.8*am)+runif(1, 0, 0.1)),
    gear =  dist_categorical(prob = list(prob_vals(gear, gear_vals)),
                            outcomes = list(gear_vals)),
    carb = dist_categorical(prob = list(prob_vals(carb, carb_vals)),
                            outcomes = list(carb_vals))
    ) |>
  ungroup() |>
  select(-id)

rownames(uncertain_mtcars) <- rownames(mtcars)

usethis::use_data(uncertain_mtcars, overwrite = TRUE)
