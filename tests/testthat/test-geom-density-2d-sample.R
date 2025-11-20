library(vdiffr)
library(ggplot2)

n <- ggplot(uncertain_faithful, aes(x = eruptions, y = waiting)) +
  geom_point_sample(size=2/10) +
  scale_x_continuous_distribution(limits = c(0.5, 6)) +
  scale_y_continuous_distribution(limits = c(40, 110))

test_that("geom_density_2d_sample tests", {
  
  set.seed(475)
  
  p1 <- n + geom_density_2d_sample(linewidth=2/10, alpha=0.5)
  expect_doppelganger("Example 1", p1)
  
  p2 <- n + geom_density_2d_filled_sample(alpha = 0.1)
  expect_doppelganger("Example 2", p2)
  
  p3 <- n + geom_density_2d_filled_sample(alpha = 0.1) +
    geom_density_2d_sample(linewidth = 0.2, colour = "black", alpha=0.5)
  expect_doppelganger("Example 3", p3)
  
  p4 <- ggplot(smaller_uncertain_diamonds, aes(x, y)) + 
    stat_density_2d_sample(geom = "point", alpha = 0.15,
                           aes(size = after_stat(density)), n = 20, contour = FALSE)
  expect_doppelganger("Example 4", p4)
  
}
)



################ PASS #################
# # If you map an aesthetic to a categorical variable, you will get a
# # set of contours for each value of that variable
# d <- ggplot(smaller_diamonds, aes(x, y))
# d + geom_density_2d(aes(colour = cut))
# b <- ggplot(smaller_uncertain_diamonds, aes(x, y))
# b + geom_density_2d_sample(aes(colour = cut), alpha=0.1)
# 
# # If we turn contouring off, we can use other geoms, such as tiles:
# d + stat_density_2d(
#   geom = "raster",
#   aes(fill = after_stat(density)),
#   contour = FALSE
# ) + scale_fill_viridis_c()
# 
# b + stat_density_2d_sample(
#   geom = "raster",
#   aes(fill = after_stat(density)),
#   contour = FALSE
# ) + scale_fill_viridis_c()
############### FAIL #################

############## UNTESTED #################
# DONT HAVE DETERMNISTIC FACET
# # If you draw filled contours across multiple facets, the same bins are
# # used across all facets
# d + geom_density_2d_filled() + facet_wrap(vars(cut))
# # If you want to make sure the peak intensity is the same in each facet,
# # use `contour_var = "ndensity"`.
# d + geom_density_2d_filled(contour_var = "ndensity") + facet_wrap(vars(cut))
# # If you want to scale intensity by the number of observations in each group,
# # use `contour_var = "count"`.
# d + geom_density_2d_filled(contour_var = "count") + facet_wrap(vars(cut))


  
