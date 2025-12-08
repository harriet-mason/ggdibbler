# load libraries
library(tidyverse)
library(distributional)


# FUNCTIONS USED IN DATA CLEANING
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

# for ordered random variables
prob_vals3 <- function(name, all_names){
  len <- length(all_names)
  x <- which(name==all_names)
  probs <- rep(0, len)
  probs[x] <- runif(1,0.7,0.8)
  posvec <- riffle(rev(seq(x-1)), seq((x+1),len))
  if(x == 1) posvec <- 2:len
  if(x == 5) posvec <- rev(1:(len-1))
  for(i in posvec){
    probs[i] <- runif(1, 0, (1-sum(probs)))
  }
  probs/sum(probs)
}

# interleave function for unequal lengths
riffle <- function(a, b) {
  n <- min(length(a), length(b))
  p1 <- as.vector(rbind(a[1:n], b[1:n]))
  p2 <- c(a[-(1:n)], b[-(1:n)]) # Remaining elements
  c(p1, p2)
}

######################################################## MPG DATA SET ####################################################
set.seed(23102025)
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

round1 <- function(x) round(x, digits=1)
uncertain_mpg <- mpg |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
# Categorical Variables: # manufacturer # model # trans # drv # fl # class
         manufacturer = dist_categorical(prob = list(prob_vals2(manufacturer, manufacturer_names)),
                                         outcomes = list(manufacturer_names)),
         model = dist_categorical(prob = list(prob_vals2(model, model_names)),
                                         outcomes = list(model_names)),
         trans = dist_categorical(prob = list(prob_vals2(trans, trans_names)),
                                         outcomes = list(trans_names)),
         drv = dist_categorical(prob = list(prob_vals2(drv, drv_names)),
                                         outcomes = list(drv_names)),
         fl = dist_categorical(prob = list(prob_vals2(fl, fl_names)),
                                         outcomes = list(fl_names)),
         class = dist_categorical(prob = list(prob_vals2(class, class_names)),
                               outcomes = list(class_names)),
# Continuous: # displ
         displ = dist_transformed(dist_uniform(displ - runif(1, 0, 1), displ + runif(1, 0, 1)),
                                  round1, identity),
# Integer: # year # cyl # cty # hwy
         year = dist_sample(list(sample(seq(from=year-2, to = year+2), replace = TRUE))),
         cyl =  dist_categorical(prob = list(prob_vals2(cyl, cyl_vals)),
                                 outcomes = list(cyl_vals)),
         cty = dist_binomial(size = round(1+cty/0.9), prob=0.9),
         hwy = dist_binomial(size = round(1+hwy/0.99), prob=0.99)) |>
  ungroup() |>
  select(-id)

usethis::use_data(uncertain_mpg, overwrite = TRUE)

################################### DIAMONDS DATA SET ################################################
set.seed(25102025)

uncertain_diamonds <- ggplot2::diamonds

cut_names <-  unique(uncertain_diamonds$cut)
color_names <-  unique(uncertain_diamonds$color)
clarity_names <-  unique(uncertain_diamonds$clarity)
sd_carat <- sd(uncertain_diamonds$carat)/10
sd_depth <- sd(uncertain_diamonds$depth)/10
sd_table <- sd(uncertain_diamonds$table)/10
sd_x <- sd(uncertain_diamonds$x)/10
sd_y <- sd(uncertain_diamonds$y)/10
sd_z <- sd(uncertain_diamonds$z)/10


uncertain_diamonds <- uncertain_diamonds |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
    price = dist_binomial(size = round(1+price/0.9), prob=0.9),
    carat = dist_normal(mu = carat, runif(1,0,sd_carat)),
    cut = dist_categorical(prob = list(prob_vals2(cut, cut_names)),
                             outcomes = list(cut_names)),
    color = dist_categorical(prob = list(prob_vals2(color, color_names)),
                           outcomes = list(color_names)),
    clarity = dist_categorical(prob = list(prob_vals2(clarity, clarity_names)),
                          outcomes = list(clarity_names)),
    depth = dist_normal(mu = depth, runif(1,0,sd_depth)),
    table = dist_normal(mu = table, runif(1,0,sd_table)),
    x = dist_normal(mu = x, runif(1,0,sd_x)),
    y = dist_normal(mu = y, runif(1,0,sd_y)),
    z = dist_normal(mu = z, runif(1,0,sd_z))) |>
  ungroup() |>
  select(-id)


# usethis::use_data(uncertain_diamonds, overwrite = TRUE)

diamond_ind <- sample(nrow(ggplot2::diamonds), size = 1000)
smaller_diamonds <- ggplot2::diamonds[diamond_ind,]
smaller_uncertain_diamonds <- uncertain_diamonds[diamond_ind,]

usethis::use_data(smaller_diamonds, overwrite = TRUE)
usethis::use_data(smaller_uncertain_diamonds, overwrite = TRUE)

################################ ECONOMICS #######################################
set.seed(28102025)

uncertain_economics <- ggplot2::economics

sd_pce <- sd(uncertain_economics$pce)/5
sd_pop <- sd(uncertain_economics$pop)/5
sd_psavert <- sd(uncertain_economics$psavert)/5
sd_uempmed <- sd(uncertain_economics$uempmed)/5
sd_unemploy <- sd(uncertain_economics$unemploy)/5

uncertain_economics <- uncertain_economics |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
    pce = dist_normal(mu = pce, runif(1,0,sd_pce)),
    pop = dist_normal(mu = pop, runif(1,0,sd_pop)),
    psavert = dist_normal(mu = psavert, runif(1,0,sd_psavert)),
    uempmed = dist_normal(mu = uempmed, runif(1,0,sd_uempmed)),
    unemploy = dist_normal(mu = unemploy, runif(1,0,sd_unemploy))) |>
  ungroup() |>
  select(-id)

usethis::use_data(uncertain_economics, overwrite = TRUE)

rescale_mean <- function(x) (x - min(x)) / diff(range(x))
rescale_variance <- function(x) x / (diff(range(x)))^2

uncertain_economics_long <- uncertain_economics |>
  pivot_longer(cols = pce:unemploy, 
               names_to = "variable", values_to = "value")|>
  mutate(mean = mean(value),
         variance = variance(value)) |>
  group_by(variable) |>
  mutate(value0 = dist_normal(rescale_mean(mean), sqrt(rescale_variance(variance)))) |>
  ungroup() |>
  select(!mean:variance)
  

usethis::use_data(uncertain_economics_long , overwrite = TRUE)

################################ FAITHFULD #######################################

set.seed(3112025)

uncertain_faithfuld <- ggplot2::faithfuld

# density is the only aesthetic that it makes sense to have randomised
uncertain_faithfuld <- uncertain_faithfuld |>
  group_by(eruptions, waiting) |>
  mutate(
    # low error
    density0 = dist_truncated(dist_normal(density, runif(1,0,0.001)),lower = 0),
    # high error
    density2 = dist_truncated(dist_normal(density, runif(1,0,0.005)),lower = 0),
    # med error
    density = dist_truncated(dist_normal(density, runif(1,0,0.003)),lower = 0)
    ) |>
  ungroup()


usethis::use_data(uncertain_faithfuld , overwrite = TRUE)

################################ FAITHFUL #######################################

set.seed(17112025)

uncertain_faithful <- faithful

# density is the only aesthetic that it makes sense to have randomised
uncertain_faithful <- uncertain_faithful |>
  group_by(eruptions, waiting) |>
  mutate(
    waiting = dist_normal(waiting, 2),
    eruptions = dist_normal(eruptions, 0.8)
    ) |>
  ungroup()

usethis::use_data(uncertain_faithful , overwrite = TRUE)

