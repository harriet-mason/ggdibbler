library(vdiffr)
library(ggplot2)

test_that("stat_ellipse_sample tests", {
  
  set.seed(555)
  
  
  p2 <- ggplot(uncertain_faithful, 
               aes(waiting, eruptions, 
                   color = dist_transformed(eruptions,function(x) x > 3, identity))) +
    geom_point_sample() +
    stat_ellipse_sample(type = "norm", linetype = 2) +
    stat_ellipse_sample(type = "t") +
    labs(colour = "eruptions > 3")
  expect_doppelganger("Example 2", p2)
  
  p4 <- ggplot(uncertain_faithful, 
               aes(waiting, eruptions, 
                   fill = dist_transformed(eruptions, function(x) x > 3, identity))) +
    stat_ellipse_sample(geom = "polygon", alpha=0.1) +
    labs(fill = "eruptions > 3")
  expect_doppelganger("Example 4", p4)

  
}
)


