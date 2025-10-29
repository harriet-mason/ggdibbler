library(vdiffr)
library(ggplot2)
library(distributional)
library(dplyr)

test_that("geom_bar_sample tests", {
  # no random variables used - just return normal points
  set.seed(342830498)
  p0 <- ggplot(mpg, aes(class)) + geom_bar_sample()
  expect_doppelganger("deterministic", p0)
  
  p1 <- ggplot(uncertain_mpg, aes(class)) + geom_bar_sample()
    expect_doppelganger("example1", p1)

  # random variables x and y
  p2 <- ggplot(uncertain_mpg, aes(class)) + geom_bar_sample(aes(weight = displ))
    expect_doppelganger("example2", p2)
  
  p3 <- ggplot(uncertain_mpg) + geom_bar_sample(aes(y = class))
  expect_doppelganger("example3", p3)
}
)

####################### FAIL #################
####################### UNTESTED #################

# g <- ggplot(mpg, aes(class))
# q <- ggplot(mpg, aes(class))
# 
# # POSITION ISSUES
# g + geom_bar(aes(fill = drv))
# q + geom_bar_sample(aes(fill = drv) alpha=0.3)
# 
# # SAME ISSUE
# ggplot(mpg, aes(y = class)) +
#   geom_bar(aes(fill = drv), position = position_stack(reverse = TRUE)) +
#   theme(legend.position = "top")
# ggplot(uncertain_mpg, aes(y = class)) +
#   geom_bar_sample(aes(fill = drv), position = position_stack(reverse = TRUE)) +
#   theme(legend.position = "top")

