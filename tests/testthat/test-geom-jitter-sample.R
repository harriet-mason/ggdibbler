# load libraries
library(ggplot2)
library(distributional)
library(vdiffr)
set.seed(1)
# set up data
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
  deterministic_colour = c("A", "B", "C")
  )


test_that("geom_jitter_sample tests", {
  # no random variables used - just return normal points
  set.seed(2)
  p1 <- ggplot() + 
    geom_jitter_sample(data = point_data, width = 0.1, height=0.1,
                       aes(x=deterministic_xy, y=deterministic_xy, colour = random_colour))
  expect_doppelganger("Example 1", p1)
}
)