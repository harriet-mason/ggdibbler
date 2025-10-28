# load libraries
library(ggplot2)
library(distributional)
library(vdiffr)

test_that("geom_count_sample tests", {
  # no random variables used - just return normal points
  set.seed(27102025)
  p1 <- ggplot(uncertain_mpg, aes(cty, hwy)) +
    geom_count_sample(alpha=0.2) 
  expect_doppelganger("example1", p1)
  
  # random variables x and y
  p2 <- ggplot(uncertain_mpg, aes(cty, hwy)) +
    geom_count_sample(alpha=0.2) +
    scale_size_area()
  expect_doppelganger("example2", p2)
}
)