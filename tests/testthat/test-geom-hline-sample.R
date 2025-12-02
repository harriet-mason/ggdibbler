library(vdiffr)
library(ggplot2)
library(distributional)

q <- ggplot(uncertain_mtcars, aes(wt, mpg)) + 
  geom_point_sample(seed=5)

test_that("geom_hline_sample tests", {
  
  set.seed(438)

  q1 <- q + geom_hline_sample(yintercept = dist_normal(20, 1),
                              seed=5)
  expect_doppelganger("Example 1", q1)
  
  
}
)
