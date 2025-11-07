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

test_that("geom_linerange_sample tests", {
  
  set.seed(444)
  p1 <- q + 
    geom_linerange_sample(aes(ymin = lower, ymax = upper), , alpha=0.7,
                                  position=position_jitter(height=0, width=0.05))
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_df, aes(resp, trt, colour = group)) +
    geom_linerange_sample(aes(xmin = lower, xmax = upper), alpha=0.7,
                          position=position_jitter(height=0.05, width=0))
  expect_doppelganger("Example 2", p2)
  
}
)
















############### FAIL #################
############## UNTESTED #################

# # If you want to dodge bars and errorbars, you need to manually
# # specify the dodge width
# # ggplot
# p <- ggplot(df, aes(trt, resp, fill = group))
# p +
#   geom_col(position = "dodge") +
#   geom_errorbar(aes(ymin = lower, ymax = upper), position = "dodge", width = 0.25)
# # NEED NESTED POSITION - POSITION_DODGE_IDENTITY OR EVEN POSITION_DODGE_DODGE
# # THIS DOES POSITION_DODGE_DODGE THE OTHER WAY AROUND (MAIN PLOT INSIDE OF DIST)
# # ggdibbler
# q <- ggplot(uncertain_df, aes(trt, resp, fill = group))
# q +
#   geom_col_sample(position = "dodge") +
#   geom_errorbar_sample(aes(ymin = lower, ymax = upper), position = "dodge", width = 0.25)
# 
# # Because the bars and errorbars have different widths
# # we need to specify how wide the objects we are dodging are
# # ggplot
# dodge <- position_dodge(width=0.9)
# p +
#   geom_col(position = dodge) +
#   geom_errorbar(aes(ymin = lower, ymax = upper), position = dodge, width = 0.25)
# # ggdibbler
# q +
#   geom_col_sample(position = dodge) +
#   geom_errorbar_sample(aes(ymin = lower, ymax = upper), position = dodge, width = 0.25)
# 
# # When using geom_errorbar() with position_dodge2(), extra padding will be
# # needed between the error bars to keep them aligned with the bars.
# p +
#   geom_col(position = "dodge2") +
#   geom_errorbar(
#     aes(ymin = lower, ymax = upper),
#     position = position_dodge2(width = 0.5, padding = 0.5)
#   )
# 
# q +
#   geom_col_sample(position = "dodge2") +
#   geom_errorbar_sample(
#     aes(ymin = lower, ymax = upper),
#     position = position_dodge2(width = 0.5, padding = 0.5)
#   )