library(vdiffr)
library(ggplot2)
library(distributional)
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point() 

test_that("geom_vline_sample tests", {
  
  set.seed(438)
  
  q1 <- ggplot(uncertain_mtcars, aes(wt, mpg)) + geom_point_sample()
  
  q4 <- q1 + geom_vline_sample(xintercept = dist_normal(5, 0.1)) + 
    scale_x_continuous_distribution(limits = c(0,6)) + 
    scale_y_continuous_distribution(limits = c(10,35)) 
  expect_doppelganger("Example 4", q4)
  
  q5 <- q1 + geom_vline_sample(xintercept = dist_normal(1:5, 0.1)) 
  expect_doppelganger("Example 5", q5)
  
}
)