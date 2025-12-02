library(vdiffr)
library(ggplot2)
library(distributional)
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point() 
q <- ggplot(uncertain_mtcars, aes(wt, mpg)) + 
  geom_point_sample(seed=10)

test_that("geom_abhvline_sample tests", {
  
  set.seed(438)
  
  q2 <- q + geom_abline_sample(intercept = dist_normal(20, 1), 
                               alpha=0.3, seed=10) 
  expect_doppelganger("Example 2", q2)
  
  q7 <- p + geom_abline_sample(intercept = dist_normal(37, 1.8), slope = dist_normal(-5, 0.56),
                               times=30, alpha=0.5, seed=10)
  expect_doppelganger("Example 7", q7)
  
}
)


