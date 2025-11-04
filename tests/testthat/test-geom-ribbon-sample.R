library(vdiffr)
library(distributional)
library(dplyr)
library(ggplot2)

# Generate data
huron <- data.frame(year = 1875:1972, level = as.vector(LakeHuron))
uncertain_huron <- huron |>
  group_by(year) |>
  mutate(level = dist_normal(level, runif(1,0,2)))
q <- ggplot(uncertain_huron, aes(year))

df <- data.frame(
  g = c("a", "a", "a", "b", "b", "b"),
  x = c(1, 3, 5, 2, 4, 6),
  y = c(2, 5, 1, 3, 6, 7)
)
uncertain_df <- df |>
  mutate(x = dist_normal(x, 0.8),
         y = dist_normal(y, 0.8))


test_that("geom_ribbon_sample tests", {
  
  set.seed(545)
  
  p1 <- q <- ggplot(uncertain_huron, aes(year))
  expect_doppelganger("Example 1", p1)
  
  p2 <- q + geom_ribbon_sample(aes(ymin=0, ymax=level), alpha=0.2)
  expect_doppelganger("Example 2", p2)
  
  p3 <- q + geom_area_sample(aes(y = level), alpha=0.2)
  expect_doppelganger("Example 3", p3)
  
  p4 <- q + geom_area_sample(aes(x = level, y = year), orientation = "y", alpha=0.2)
  expect_doppelganger("Example 4", p4)
  
  p5 <- q + 
    geom_ribbon_sample(aes(ymin = level - 1, ymax = level + 1), fill = "grey70", alpha=0.2) +
    geom_line_sample(aes(y = level), alpha=0.2)
  expect_doppelganger("Example 5", p5)
  
  p6 <- ggplot(uncertain_df, aes(x, y, fill = g)) +
    geom_area_sample(alpha=0.2) +
    facet_grid(g ~ .)
  expect_doppelganger("Example 6", p6)
}
)

################ PASS #################

############### FAIL #################
############## UNTESTED OR NEEDS IMPROVEMENTS #################

# PROPPER EXAMPLE BELOW NEEDS SET SEED AND NESTED POSITIONS
# 
# # The underlying stat_align() takes care of unaligned data points
# df <- data.frame(
#   g = c("a", "a", "a", "b", "b", "b"),
#   x = c(1, 3, 5, 2, 4, 6),
#   y = c(2, 5, 1, 3, 6, 7)
# )
# uncertain_df <- df |>
#   mutate(x = dist_normal(x, 0.8),
#          y = dist_normal(y, 0.8))
# 
# a <- ggplot(df, aes(x, y, fill = g)) +
#   geom_area()
# 
# b <- ggplot(uncertain_df, aes(x, y, fill = g)) +
#   geom_area_sample(alpha=0.2)
# 
# # NEED SET SEED OPTION
# # Two groups have points on different X values.
# a + facet_grid(g ~ .)  + geom_point(size = 8)
# b + facet_grid(g ~ .) + geom_point_sample(size = 5, alpha=0.2)
# 
# # NEED NESTED POSITIONS
# # stat_align() interpolates and aligns the value so that the areas can stack
# # properly.
# a + geom_point(stat = "align", position = "stack", size = 8)
# b + geom_point_sample(stat = "align_sample", 
#                       position = "stack_identity", size = 8, alpha=0.2) # +
# # To turn off the alignment, the stat can be set to "identity"
# ggplot(df, aes(x, y, fill = g)) +
#   geom_area(stat = "identity")
