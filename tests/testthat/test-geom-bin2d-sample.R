library(vdiffr)
library(ggplot2)
b <- ggplot(smaller_uncertain_diamonds, aes(x, y)) 

test_that("geom_bin_2d_sample tests", {
  
  set.seed(999)
  
  p1 <- b + geom_bin_2d_sample(times=100)
  expect_doppelganger("Example 1", p1)
  
  p2 <- b + geom_bin_2d_sample(position="identity", alpha=0.2)
  expect_doppelganger("Example 2", p2)
  
  p3 <- b + geom_bin_2d_sample(bins = 10) #ggdibbler
  expect_doppelganger("Example 3", p3)
  
  p4 <- b + geom_bin_2d_sample(bins = list(x = 30, y = 10)) #ggdibbler
  expect_doppelganger("Example 4", p4)
  
  p5 <- b + geom_bin_2d_sample(binwidth = c(0.1, 0.1))
  expect_doppelganger("Example 5", p5)
  
}
)
