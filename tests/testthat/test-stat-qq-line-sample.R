library(vdiffr)
library(ggplot2)
library(distributional)

df <- data.frame(y = rt(200, df = 5))
uncertain_df <- data.frame(y=dist_normal(rt(200, df = 5), runif(200)))

params <- list(m = -0.02505057194115, s = 1.122568610124, df = 6.63842653897)

q <- ggplot(uncertain_df, aes(sample = y))


test_that("geom_qq_line_sample tests", {
  
  set.seed(8787)
  
  p1 <- q + stat_qq_line_sample()
  expect_doppelganger("Generated norm", p1)
  
  p3 <- q + stat_qq_line_sample(distribution = qt, dparams = params["df"])
  expect_doppelganger("Set parameters", p3)
  
  p4 <- ggplot(uncertain_mtcars, aes(sample = mpg)) +
    stat_qq_line_sample()
  expect_doppelganger("With mtcars data", p4)
  
}
)


