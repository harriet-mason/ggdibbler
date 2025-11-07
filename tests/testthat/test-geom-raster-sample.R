library(vdiffr)
library(ggplot2)
library(distributional)
library(dplyr)

# Extra data for last example
df <- expand.grid(x = 0:5, y = 0:5)
set.seed(1)
df$z <- runif(nrow(df))
uncertain_df <- df |> 
  group_by(x,y) |>
  mutate(z = dist_normal(z, runif(1, 0, 0.1))) |>
  ungroup()


test_that("geom_raster_sample tests", {
  
  set.seed(342)
  p1 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
    geom_raster_sample(aes(fill = density)) 
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
    geom_raster_sample(aes(fill = density2)) 
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions)) + 
    geom_raster_sample(aes(fill = density), position="dodge", interpolate = TRUE)
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(uncertain_df, aes(x, y, fill = z)) +
    geom_raster_sample()
  expect_doppelganger("Example 4", p4)
  
  p5 <- ggplot(uncertain_df, aes(x, y, fill = z)) +
    geom_raster_sample(hjust = 0, vjust = 0)
  expect_doppelganger("Example 5", p5)
}
)


# ################ PASS #################
# ############### FAIL #################
# ############## UNTESTED #################

