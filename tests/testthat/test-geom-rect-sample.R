library(vdiffr)
library(dplyr)
library(ggplot2)
library(distributional)

tile_df <- data.frame(
  x = rep(c(2, 5, 7, 9, 12), 2),
  y = rep(c(1, 2), each = 5),
  z = factor(rep(1:5, each = 2)),
  w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
)

rect_df  <- tile_df |>
  mutate(xmin = x - w / 2,
         xmax = x + w / 2,
         ymin = y,
         ymax = y + 1)

uncertain_rect  <- rect_df|>
  mutate(xmin = dist_normal(xmin, 0.5),
         xmax = dist_normal(xmax, 0.5),
         ymin = dist_normal(ymin, 0.5),
         ymax = dist_normal(ymax, 0.5))

test_that("geom_rect_sample tests", {
  set.seed(44)
  
  p1 <- ggplot(data = uncertain_rect,
               aes(xmin= xmin, xmax = xmax, ymin = ymin, ymax = ymax, f = z)) +
    geom_rect_sample(aes(fill = as.factor(after_stat(f))), colour = "grey50", alpha=0.2) +
    labs(fill = "z")
  
  expect_doppelganger("Example 1", p1)
}
)
 





