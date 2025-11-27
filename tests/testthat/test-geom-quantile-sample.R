library(ggplot2)
library(vdiffr)
n <- ggplot(uncertain_mpg, aes(displ, hwy))

suppressMessages({
test_that("geom_quantile_sample tests", {
  
  set.seed(4343)
  
  p1 <- n + geom_quantile_sample()
  expect_doppelganger("Example 1", p1)
  
  p3 <- n + geom_quantile_sample(method = "rqss")
  expect_doppelganger("Example 3", p3)
  
}
)
})
