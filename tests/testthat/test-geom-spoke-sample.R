# load libraries
library(vdiffr)
library(ggplot2)
library(dplyr)
library(distributional)

# deterministic data
set.seed(1)
df <- expand.grid(x = 1:10, y=1:10)
df$angle <- runif(100, 0, 2*pi)
df$speed <- runif(100, 0, sqrt(0.1 * df$x))

# uncertain data
uncertain_df <- df |>
  group_by(x,y) |>
  mutate(angle = dist_normal(angle, runif(1,0, 0.5)),
         speed = dist_normal(speed, runif(1,0, 0.1))) |>
  ungroup()


test_that("geom_spoke_sample tests", {
  
  set.seed(98)
  
  p1 <- ggplot(uncertain_df, aes(x, y)) +
    geom_point() + 
    geom_spoke_sample(aes(angle = angle), radius = 0.5, alpha=0.3)
  
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_df, aes(x, y)) +
    geom_point_sample() + 
    geom_spoke_sample(aes(angle = angle, radius = speed), alpha=0.3)
  
  expect_doppelganger("Example 2", p2)
}
)
