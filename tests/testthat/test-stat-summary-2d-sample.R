library(vdiffr)
library(ggplot2)
b <- ggplot(smaller_uncertain_diamonds, 
            aes(carat, depth, z = price))

test_that("stat_summary_2d_sample tests", {
  
  set.seed(445)
  
  p1 <- b + stat_summary_2d_sample()
  expect_doppelganger("Example 1", p1)
  
  p4 <- b + stat_summary_2d_sample(fun = "quantile", fun.args = list(probs = 0.1))
  expect_doppelganger("Example 4", p4)
  
}
)

