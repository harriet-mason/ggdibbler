# load libraries
library(ggplot2)
library(distributional)
library(vdiffr)

# set up data
set.seed(1)
point_data <- data.frame(
  random_x = c(dist_uniform(2,3),
               dist_normal(3,2), 
               dist_exponential(3)),
  random_y = c(dist_gamma(2,1),
               dist_sample(x = list(rnorm(100, 5, 1))),
               dist_exponential(1)),
  # have some uncertainty as to which category each value belongs to
  random_colour = dist_categorical(prob = list(c(0.8,0.15,0.05),
                                               c(0.25,0.7,0.05),
                                               c(0.25,0,0.75)), 
                                   outcomes = list(c("A", "B", "C"))),
  deterministic_xy = c(1,2,3),
  deterministic_colour = c("A", "B", "C"))


test_that("geom_rug_sample tests", {
  # no random variables used - just return normal points
  set.seed(2)
  p1 <- ggplot() + 
    geom_point_sample(data = point_data, aes(x=random_x, y=random_y)) +
    geom_rug_sample(data = point_data, aes(x=random_x, y=random_y))
  expect_doppelganger("Example 1", p1)
}
)