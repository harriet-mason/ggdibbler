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
  
  q <- ggplot(uncertain_huron, aes(year))
  
  p2 <- q + geom_ribbon_sample(aes(ymin=0, ymax=level), alpha=0.2)
  expect_doppelganger("Example 2", p2)
  
  p5 <- q + 
    geom_ribbon_sample(aes(ymin = level - 1, ymax = level + 1), 
                       fill = "grey70", seed=4) +
    geom_line_sample(aes(y = level), seed=4)
  expect_doppelganger("Example 5", p5)
  
  p7 <- ggplot(uncertain_df, aes(x, y, fill = g)) +
    geom_area_sample(seed=5) + 
    geom_point_sample(stat = "align_sample", position = "stack_identity",
                      seed=5)
  expect_doppelganger("Example 7", p7)
}
)


# ggplot
