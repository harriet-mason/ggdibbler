library(vdiffr)
library(ggplot2)
library(distributional)

df <- data.frame(y = rt(200, df = 5))
uncertain_df <- data.frame(y=dist_normal(rt(200, df = 5), runif(200)))
params <- list(m = -0.02505057194115, s = 1.122568610124, df = 6.63842653897)
q <- ggplot(uncertain_df, aes(sample = y))


test_that("geom_qq_sample tests", {
  
  set.seed(980)
  
  p1 <- q + stat_qq_sample(alpha=0.2, size=0.5) 
  expect_doppelganger("Example 1", p1)
  
  p2 <- q + geom_qq_sample(alpha=0.2, size=0.5) 
  expect_doppelganger("Example 2", p2)
  
  p3 <- q + stat_qq_sample(distribution = qt, alpha=0.2,
                           dparams = params["df"])
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(uncertain_mtcars, aes(sample = mpg)) +
    stat_qq_sample(alpha=0.2) 
  expect_doppelganger("Example 4", p4)
  
}
)