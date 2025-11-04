library(vdiffr)
library(ggplot2)

df <- data.frame(x1 = 2.62, x2 = 3.57, 
                 y1 = 21.0, y2 = 15.0)
uncertain_df <- data.frame(x1 = dist_normal(2.62, 0.1), 
                           x2 = dist_normal(3.57,0.1), 
                           y1 = dist_normal(21.0, 0.1), 
                           y2 = dist_normal(15.0,0.1))

a <- ggplot(uncertain_mtcars, aes(wt, mpg)) +
  geom_point_sample(size=0.1) +
  scale_x_continuous_distribution(limits = c(1,6)) +
  scale_y_continuous_distribution(limits = c(8,36))


test_that("geom_curve_sample tests", {
  
  set.seed(43)
  
  p1 <- a +
    geom_curve_sample(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "curve"), 
                      data = uncertain_df, alpha=0.5) +
    geom_segment_sample(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "segment"), 
                        data = uncertain_df, alpha=0.5)
  
  expect_doppelganger("Example 1", p1)
  
  # ggdibbler
  p2 <- a + geom_curve_sample(aes(x = x1, y = y1, xend = x2, yend = y2), curvature = -0.2,
                        data = uncertain_df, alpha=0.5)
  
  # ggdibbler
  p3 <- a + geom_curve_sample(aes(x = x1, y = y1, xend = x2, yend = y2), 
                        data = uncertain_df, alpha=0.5, curvature = 1)
  
  # ggdibbler
  p4 <- a + geom_curve_sample(
    aes(x = x1, y = y1, xend = x2, yend = y2),
    data = uncertain_df, alpha=0.5,
    arrow = arrow(length = unit(0.03, "npc"))
  )
  
  
}
)

################ PASS #################
############### FAIL #################
############## UNTESTED #################