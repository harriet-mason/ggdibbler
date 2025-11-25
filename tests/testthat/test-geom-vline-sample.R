library(vdiffr)
library(ggplot2)
library(distributional)

q <- ggplot(uncertain_mtcars, aes(wt, mpg)) + 
  geom_point_sample(seed=44)

test_that("geom_vline_sample tests", {
  
  set.seed(438)
  
  q4 <- q + geom_vline_sample(xintercept = dist_normal(5, 0.1),
                              seed=44)
  expect_doppelganger("Example 4", q4)
  
  q5 <- q + geom_vline_sample(xintercept = dist_normal(1:5, 0.1),
                              seed=44) 
  expect_doppelganger("Example 5", q5)
  
}
)