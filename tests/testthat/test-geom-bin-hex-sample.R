library(vdiffr)
library(ggplot2)
b <- ggplot(smaller_uncertain_diamonds, aes(carat, price))

test_that("geom_hex_sample tests", {
  
  set.seed(890)
  p1 <- b + geom_hex_sample(alpha=0.15)
  expect_doppelganger("Example 1", p1)
  
  p2 <- b + geom_hex_sample(bins = 10, alpha=0.15)
  expect_doppelganger("Example 2", p2)
  
  p3 <- b + geom_hex_sample(bins = 30, alpha=0.15)
  expect_doppelganger("Example 3", p3)
  
  p4 <- b + geom_hex_sample(binwidth = c(1, 1000), alpha=0.15)
  expect_doppelganger("Example 4", p4)
  
  p5 <- b + geom_hex_sample(binwidth = c(.1, 500), alpha=0.15)
  expect_doppelganger("Example 5", p5)
}
)
