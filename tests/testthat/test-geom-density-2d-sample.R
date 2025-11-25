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

  
}
)


  
