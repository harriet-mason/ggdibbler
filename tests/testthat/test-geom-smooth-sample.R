library(vdiffr)

suppressMessages({
test_that("geom_smooth_sample tests", {

  set.seed(573)
  
  p1 <- ggplot(uncertain_mpg, aes(displ, hwy)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1)
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_mpg, aes(displ, hwy, colour = class)) +
    geom_point_sample(alpha=0.5, size=0.2) +
    geom_smooth_sample(linewidth=0.2, alpha=0.1, se = FALSE, method = lm)
  expect_doppelganger("Example 2", p2)
  
  })
})



