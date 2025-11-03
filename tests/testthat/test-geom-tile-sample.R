# load library
library(vdiffr)
library(ggplot2)
library(distributional)
library(dplyr)


logic_to_y <- function(x){
  as.integer(x) + 1
}
y_to_logic <- function(x){
  rlang::as_logical(x-1)
}

uncertain_df <- data.frame(
  x = dist_binomial(rep(c(2, 5, 7, 9, 12), 2), 0.9),
  y = dist_transformed(dist_bernoulli(0.4*df$y), logic_to_y , y_to_logic),
  z = dist_binomial(rep(1:5, each = 2), 0.9),
  w = dist_binomial(rep(diff(c(0, 4, 6, 8, 10, 14)), 2), 0.9)
)

# More likely that the positions are deterministic and the colour is random
# deterministic x & y, random z
uncertain_df2 <- data.frame(
  x = rep(c(2, 5, 7, 9, 12), 2),
  y = rep(c(1, 2), each = 5),
  z = dist_binomial(rep(1:5, each = 2), 0.5),
  w = rep(diff(c(0, 4, 6, 8, 10, 14)), 2)
)

uncertain_df3 <- mutate(uncertain_df2, z =  dist_binomial(rep(1:5, each = 2), 0.99))


test_that("geom_tile_sample tests", {
  set.seed(12345)
  
  p1 <- ggplot(uncertain_df2, aes(x, y)) +
    geom_tile_sample(aes(fill = z), position="dodge") +
    geom_tile(fill = NA, colour = "black", linewidth=1) +
    scale_fill_distiller(palette = "Spectral")
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_df, aes(x, y)) +
    geom_tile_sample(aes(fill = z), colour = "grey50", alpha=0.2) +
    scale_y_continuous_distribution(limits= c(0.5,2.5)) +
    scale_x_continuous_distribution(limits= c(0,13))
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_df3, aes(x, y, f = z, width = w)) +
    geom_tile_sample(aes(fill = as.factor(after_stat(f)+1)), colour = "grey50", alpha=0.2) +
    labs(fill = "z")
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(uncertain_df2, aes(x, y, f = z, width = w)) +
    geom_tile_sample(aes(fill = as.factor(after_stat(f)+1)), colour = "grey50", alpha=0.2) +
    labs(fill = "z")
  expect_doppelganger("Example 4", p4)
  
  p5 <- ggplot(uncertain_df, aes(x, y, f = z, width = w)) +
    geom_tile_sample(aes(fill = as.factor(after_stat(f))), colour = "grey50", alpha=0.1) +
    scale_y_continuous_distribution(limits= c(0.5,2.5)) +
    scale_x_continuous_distribution(limits= c(0,13)) 
  expect_doppelganger("Example 5", p5)
}
)


# ################ PASS ################
# # ############### FAIL #################
# # ############## UNTESTED #################

# # Inspired by the image-density plots of Ken Knoblauch
# cars <- ggplot(mtcars, aes(mpg, factor(cyl)))
# cars + geom_point()
# cars + stat_bin_2d(aes(fill = after_stat(count)), binwidth = c(3,1))
# cars + stat_bin_2d(aes(fill = after_stat(density)), binwidth = c(3,1))
# cars +
#   stat_density(
#     aes(fill = after_stat(density)),
#     geom = "raster",
#     position = "identity"
#   )
# cars +
#   stat_density(
#     aes(fill = after_stat(count)),
#     geom = "raster",
#     position = "identity"
#   )
