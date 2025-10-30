library(vdiffr)
library(ggplot2)
library(distributional)

test_that("geom_density_sample tests", {
  set.seed(323894)
  p1 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_density_sample(linewidth=0.2)
  expect_doppelganger("example1", p1)

  p2 <- ggplot(smaller_uncertain_diamonds, aes(y = carat)) +
    geom_density_sample()
  expect_doppelganger("example2", p2)
  
  p3 <- ggplot(smaller_uncertain_diamonds, aes(carat)) +
    geom_density_sample(adjust = 1/5)
  expect_doppelganger("example3", p3)

  p4 <- ggplot(smaller_uncertain_diamonds, aes(depth, colour = cut)) +
    geom_density_sample() +
    scale_x_continuous_distribution(limits=c(55, 70)) + # ggdibbler does not have an xlim (yet)
    theme(palette.colour.discrete = "viridis") # bug: random variables have different colour
  expect_doppelganger("example4", p4)
  
  p5 <- ggplot(smaller_uncertain_diamonds, aes(depth, fill = cut)) +
    geom_density_sample(aes(colour = after_stat(fill)), alpha = 0.1) +
    scale_x_continuous_distribution(limits=c(55, 70)) + # ggdibbler does not have an xlim (yet)
    theme(palette.colour.discrete = "viridis",
          palette.fill.discrete = "viridis") # bug: random variables have different colour
  expect_doppelganger("example5", p5)
  
  big_uncertain_diamonds <- smaller_uncertain_diamonds[smaller_diamonds$carat >= 1, ]
  p6 <- ggplot(big_uncertain_diamonds, aes(carat)) +
    geom_density_sample(color = 'red') +
    geom_density_sample(bounds = c(1, Inf), color = 'blue')
  # expect_doppelganger("example6", suppressWarnings(p6))
  
}
)




# -------------------------------- FAILS ---------------------------
# NEED SEPARATE POSITION ADJUSTMENT FOR SAMPLE AND ACTUAL GROUPS
# ggplot(smaller_diamonds, aes(carat, after_stat(count), fill = cut)) +
#   geom_density(position = "stack") #ggplot
# ggplot(smaller_uncertain_diamonds, aes(carat, after_stat(count), fill = cut)) +
#   geom_density_sample(position = "stack", times=10) #ggdibbler
# 
# # SAME ISSUE
# ggplot(smaller_diamonds, aes(carat, after_stat(count), fill = cut)) +
#   geom_density(position = "fill")
# ggplot(smaller_uncertain_diamonds, aes(carat, after_stat(count), fill = cut)) +
#   geom_density_sample(position = "fill")
# 
# # SAME ISSUE
# ggplot(smaller_diamonds, aes(carat, fill = cut)) +
#   geom_density(position = "stack")
# ggplot(smaller_uncertain_diamonds, aes(carat, fill = cut)) +
#   geom_density_sample(position = "stack")












