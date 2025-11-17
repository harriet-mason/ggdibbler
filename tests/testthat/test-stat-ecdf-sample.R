library(vdiffr)
library(ggplot2)
library(dplyr)
set.seed(44)
# df
df <- data.frame(
  x = c(rnorm(100, 0, 3), rnorm(100, 0, 10)),
  g = gl(2, 100)
)
uncertain_df <- df |>
  group_by(x) |>
  mutate(x = dist_normal(x, runif(1,0,5)),
         g_pred = dist_bernoulli(0.9-0.8*(2-as.numeric(g)))
  )

test_that("stat_ecf_sample tests", {
  
  set.seed(4542)
  p1 <- ggplot(uncertain_df, aes(x)) +
    stat_ecdf_sample(geom = "step", alpha=0.3)
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_df, aes(x)) +
    stat_ecdf_sample(geom = "step", , alpha=0.3, pad = FALSE)
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_df, aes(x, colour = g)) +
    stat_ecdf_sample(alpha=0.3)
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(uncertain_df, aes(x, colour = g_pred)) +
    stat_ecdf_sample(alpha=0.3)
  expect_doppelganger("Example 4", p4)
  
  
}
)




################ PASS #################
############### FAIL #################
############## UNTESTED #################

# Using weighted eCDF
# weighted <- data.frame(x = 1:10, weights = c(1:5, 5:1))
# plain <- data.frame(x = rep(weighted$x, weighted$weights))
# 
# ggplot(plain, aes(x)) +
#   stat_ecdf(linewidth = 1) +
#   stat_ecdf(
#     aes(weight = weights),
#     data = weighted, colour = "green"
#   )
