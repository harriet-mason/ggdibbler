library(vdiffr)
library(ggplot2)
library(dplyr)
library(distributional)

df <- data.frame(
  trt = factor(c(1, 1, 2, 2)),
  resp = c(1, 5, 3, 4),
  group = factor(c(1, 2, 1, 2)),
  upper = c(1.1, 5.3, 3.3, 4.2),
  lower = c(0.8, 4.6, 2.4, 3.6)
)


uncertain_df <- df |>
  group_by(trt, group) |>
  mutate(resp = dist_normal(resp, runif(1,0,0.2)),
         upper = dist_normal(upper, runif(1,0,0.2)),
         lower = dist_normal(lower, runif(1,0,0.2))
  )

q <- ggplot(uncertain_df, aes(trt, resp, colour = group))

test_that("geom_errorbar_sample tests", {
  
  set.seed(44)
  p1 <- q + geom_errorbar_sample(aes(ymin = lower, ymax = upper), width = 0.2)
  
  expect_doppelganger("Example 1", p1)
  
  p2 <- q +
    geom_line_sample(aes(group = group), alpha=0.5) +
    geom_errorbar_sample(aes(ymin = lower, ymax = upper), width = 0.2, alpha=0.5)
  
  expect_doppelganger("Example 2", p2)
  
}
)
