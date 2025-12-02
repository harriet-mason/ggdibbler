# load libraries
library(vdiffr)
library(ggplot2)

suppressMessages({
test_that("geom_histogram_sample tests", {

  set.seed(34)
  p1 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_histogram_sample()
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_histogram_sample(position="identity_dodge", alpha=1) # dodge
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(smaller_uncertain_diamonds, aes(price, colour = cut)) +
    geom_freqpoly_sample(binwidth = 500, alpha=0.5)
  expect_doppelganger("Example 3", p3)

}
)
})




