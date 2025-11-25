library(vdiffr)
library(ggplot2)
u1 <- ggplot(uncertain_faithfuld, aes(waiting, eruptions, z = density))

test_that("geom_contour_sample tests", {
  
  set.seed(555)
  
  p1 <- u1 + geom_contour_sample(alpha=0.2) 
  expect_doppelganger("Example 1", p1)
  
  p2 <- u1 + geom_contour_filled_sample(alpha=0.1) 
  expect_doppelganger("Example 2", p2)

}
)





