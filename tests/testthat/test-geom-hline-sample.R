library(vdiffr)
library(ggplot2)
library(distributional)
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point() 

test_that("geom_hline_sample tests", {
  
  set.seed(438)
  
  q1 <- ggplot(uncertain_mtcars, aes(wt, mpg)) + geom_point_sample()
  
  q6 <- q1 + geom_hline_sample(yintercept = dist_normal(20, 1)) + 
    scale_x_continuous_distribution(limits = c(0,6)) + 
    scale_y_continuous_distribution(limits = c(10,35)) 
  expect_doppelganger("Example 6", q6)
  
  
}
)
