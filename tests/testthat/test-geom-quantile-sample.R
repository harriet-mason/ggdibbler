
library(ggplot2)
library(vdiffr)

test_that("geom_quantile_sample tests", {
  
  set.seed(4343)
  
  n <- ggplot(uncertain_mpg, aes(displ, hwy)) 
  
  p1 <- n + geom_quantile_sample(alpha=0.5, linewidth=0.5)
  expect_doppelganger("Example 1", p1)
  
  q10 <- seq(0.05, 0.95, by = 0.05)
  p2 <- n + geom_quantile_sample(quantiles = q10, alpha=0.5, linewidth=0.5)
  expect_doppelganger("Example 2", p2)
  
  p3 <- n + geom_quantile_sample(method = "rqss",
                                 alpha=0.5, linewidth=0.5)
  expect_doppelganger("Example 3", p3)
  
}
)

# cases work but throw warnings
# n + geom_quantile_sample(quantiles = 0.5, 
#                          alpha=0.5, linewidth=0.5)
# n + geom_quantile_sample(method = "rqss", lambda = 0.1,
#                          alpha=0.5, linewidth=0.5)
# n + geom_quantile_sample(colour = "red", linewidth = 2, alpha = 0.5)
