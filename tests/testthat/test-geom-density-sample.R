library(vdiffr)
library(ggplot2)
library(distributional)

test_that("geom_density_sample tests", {
  set.seed(323894)
  p1 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_density_sample(linewidth=0.2)
  expect_doppelganger("example1", p1)

  p2 <- ggplot(smaller_uncertain_diamonds, aes(y = carat)) +
    geom_density_sample(adjust = 1/5)
  expect_doppelganger("example2", p2)
  
  p5 <- ggplot(smaller_uncertain_diamonds, aes(depth, fill = cut)) +
    geom_density_sample(aes(colour = after_stat(fill)), alpha = 0.1) +
    scale_x_continuous_distribution(limits=c(55, 70)) + # ggdibbler does not have an xlim (yet)
    theme(palette.colour.discrete = "viridis",
          palette.fill.discrete = "viridis") # bug: random variables have different colour
  expect_doppelganger("example5", p5)
  
}
)
