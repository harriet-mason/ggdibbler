# load library
library(vdiffr)
library(ggplot2)
library(distributional)
library(dplyr)

# If you want to draw arbitrary rectangles, use geom_tile_sample() or geom_rect_sample()
tile_df <- data.frame(
  x = rep(c(2, 5, 7, 9, 12), 2),
  y = rep(c(1, 2), each = 5),
  z = factor(rep(1:5, each = 2)),
  w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
)
# most likely case that only colour is random
uncertain_tile_df <- tile_df
uncertain_tile_df$z <- dist_transformed((1 + dist_binomial(rep(1:5, each = 2), 0.5)), factor, as.numeric)

# ggdibbler


test_that("geom_tile_sample tests", {
  set.seed(12345)
  
  p1 <- ggplot(uncertain_tile_df, aes(x, y)) +
    geom_tile_sample(aes(fill = z), position="identity_dodge") +
    geom_tile(fill = NA, colour = "grey50", linewidth=1) +
    labs(fill = "z")
  expect_doppelganger("Example 1", p1)
}
)

