# load libraries
library(vdiffr)
library(ggplot2)

test_that("geom_freqpoly_sample tests", {
  
  set.seed(43)
  p1 <- ggplot(smaller_uncertain_diamonds, aes(price, colour = cut)) +
    geom_freqpoly_sample(binwidth = 500, alpha=0.5)
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(smaller_uncertain_diamonds, aes(price, after_stat(density), colour = cut)) +
    geom_freqpoly_sample(binwidth = 500, alpha=0.5)
  expect_doppelganger("Example 2", p2)
  
}
)