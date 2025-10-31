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

# Categorical Variables
# manufacturer # model # trans # drv # fl # class
manufacturer_names <- unique(mpg$manufacturer)
model_names <- unique(mpg$model)
trans_names <- unique(mpg$trans)
drv_names <- unique(mpg$drv)
fl_names <- unique(mpg$fl)
class_names <- unique(mpg$class)

# Discrete variables (small)
cyl_vals <- unique(mpg$cyl)

uncertain_mpg <- ggplot2::mpg |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
    # Deterministic variables
    manufacturer_point = manufacturer,
    model_point = model,
    trans_point = trans,
    drv_point = drv,
    fl_point = fl,
    class_point = class,
    displ_point = displ,
    year_point = year,
    cyl_point = cyl,
    cty_point = cty,
    hwy_point = hwy,
    # Random variables
    manufacturer_dist = dist_categorical(prob = list(prob_vals2(manufacturer, manufacturer_names)),
                                   outcomes = list(manufacturer_names)),
    model_dist = dist_categorical(prob = list(prob_vals2(model, model_names)),
                                   outcomes = list(model_names)),
    trans_dist = dist_categorical(prob = list(prob_vals2(trans, trans_names)),
                                   outcomes = list(trans_names)),
    drv_dist = dist_categorical(prob = list(prob_vals2(drv, drv_names)),
                                   outcomes = list(drv_names)),
    fl_dist = dist_categorical(prob = list(prob_vals2(fl, fl_names)),
                                   outcomes = list(fl_names)),
    class_dist = dist_categorical(prob = list(prob_vals2(class, class_names)),
                         outcomes = list(class_names)),
    displ_dist = dist_uniform(displ - runif(1, 0, 1), displ + runif(1, 0, 1)),
    year_dist = dist_sample(list(sample(seq(from=year-2, to = year+2), replace = TRUE))),
    cyl_dist =  dist_categorical(prob = list(prob_vals2(cyl, cyl_vals)),
                           outcomes = list(cyl_vals)),
    cty_dist = dist_binomial(size = round(1+cty/0.9), prob=0.9),
    hwy_dist = dist_binomial(size = round(1+hwy/0.99), prob=0.99)) |>
  ungroup() |>
  select(-c(id, manufacturer:class))

usethis::use_data(uncertain_mpg, overwrite = TRUE)

################################### DIAMONDS DATA SET ################################################
set.seed(25102025)

diamond_ind <- sample(nrow(ggplot2::diamonds), size = 5000)
smaller_diamonds <- ggplot2::diamonds[diamond_ind,]

cut_names <- levels(smaller_diamonds$cut)
color_names <- levels(smaller_diamonds$color)
clarity_names <- levels(smaller_diamonds$clarity)
sd_carat <- sd(smaller_diamonds$carat)/10
sd_depth <- sd(smaller_diamonds$depth)/10
sd_table <- sd(smaller_diamonds$table)/10
sd_x <- sd(smaller_diamonds$x)/10
sd_y <- sd(smaller_diamonds$y)/10
sd_z <- sd(smaller_diamonds$z)/10


uncertain_diamonds <- smaller_diamonds |>
  tibble::rowid_to_column(var = "id") |>
  group_by(id) |>
  mutate(
    price_point = price,
    carat_point = carat,
    cut_point = cut,
    color_point = color,
    clarity_point = clarity,
    depth_point = depth,
    table_point = table,
    x_point = x,
    y_point = y,
    z_point = z,
    price_dist = dist_binomial(size = round(1+price/0.9), prob=0.9),
    carat_dist = dist_normal(mu = carat, runif(1,0,sd_carat)),
    cut_dist = dist_categorical(prob = list(prob_vals2(cut, cut_names)),
                             outcomes = list(cut_names)),
    color_dist = dist_categorical(prob = list(prob_vals2(color, color_names)),
                           outcomes = list(color_names)),
    clarity_dist = dist_categorical(prob = list(prob_vals2(clarity, clarity_names)),
                          outcomes = list(clarity_names)),
    depth_dist = dist_normal(mu = depth, runif(1,0,sd_depth)),
    table_dist = dist_normal(mu = table, runif(1,0,sd_table)),
    x_dist = dist_normal(mu = x, runif(1,0,sd_x)),
    y_dist = dist_normal(mu = y, runif(1,0,sd_y)),
    z_dist = dist_normal(mu = z, runif(1,0,sd_z))) |>
  ungroup() |>
  select(-c(id, carat:z))


usethis::use_data(uncertain_diamonds, overwrite = TRUE)

#usethis::use_data(smaller_diamonds, overwrite = TRUE)
#usethis::use_data(smaller_uncertain_diamonds, overwrite = TRUE)

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
    pce_point = pce,
    pop_point = pop,
    psavert_point = psavert,
    uempmed_point = uempmed,
    unemploy_point = unemploy,
    pce_dist = dist_normal(mu = pce, runif(1,0,sd_pce)),
    pop_dist = dist_normal(mu = pop, runif(1,0,sd_pop)),
    psavert_dist = dist_normal(mu = psavert, runif(1,0,sd_psavert)),
    uempmed_dist = dist_normal(mu = uempmed, runif(1,0,sd_uempmed)),
    unemploy_dist = dist_normal(mu = unemploy, runif(1,0,sd_unemploy))) |>
  ungroup() |>
  select(-c(id,pce:unemploy))

usethis::use_data(uncertain_economics, overwrite = TRUE)

rescale_mean <- function(x) (x - min(x)) / diff(range(x))
rescale_variance <- function(x) x / (diff(range(x)))^2

uncertain_economics_long <- ggplot2::economics_long |>
  mutate(value_point = value,
         value01_point = value01,
         value01_dist = dist_normal(value01, 0.1)) |>
  select(-c(value01, value))
  

usethis::use_data(uncertain_economics_long , overwrite = TRUE)
