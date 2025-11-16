library(vdiffr)
library(ggplot2)
u1 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions, z = density))

test_that("geom_contour_sample tests", {
  
  set.seed(555)
  
  p1 <- u1 + geom_contour_sample(alpha=0.2) 
  expect_doppelganger("Example 1", p1)
  
  p2 <- u1 + geom_contour_filled_sample(alpha=0.1) 
  expect_doppelganger("Example 2", p2)
  
  p3 <- u1 + geom_raster_sample(aes(fill = density)) +
    geom_contour_sample(colour = "white", alpha=0.1)
  expect_doppelganger("Example 3", p3)
  
}
)

############### FAIL #################
# ggplot(uncertain_faithful, aes(waiting, eruptions)) +
#   geom_density_2d_sample()

# u + geom_contour_filled_sample(position="identity_subdivide")





