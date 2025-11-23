library(vdiffr)
library(ggplot2)
b <- ggplot(smaller_uncertain_diamonds, 
            aes(carat, depth, z = price))

test_that("stat_summary_2d_sample tests", {
  
  set.seed(445)
  
  p1 <- b + stat_summary_2d_sample()
  expect_doppelganger("Example 1", p1)
  
  p2 <- b + stat_summary_2d_sample(fun = \(x) sum(x^2))
  expect_doppelganger("Example 2", p2)
  
  p3 <- b + stat_summary_2d_sample(fun = var)
  expect_doppelganger("Example 3", p3)
  
  p4 <- b + stat_summary_2d_sample(fun = "quantile", fun.args = list(probs = 0.1))
  expect_doppelganger("Example 4", p4)
  
}
)


################ PASS #################
############### FAIL #################
############## UNTESTED #################



# if (requireNamespace("hexbin")) {
#   d + stat_summary_hex()
#   d + stat_summary_hex(fun = ~ sum(.x^2))
# }