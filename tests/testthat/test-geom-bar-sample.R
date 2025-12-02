library(vdiffr)
library(ggplot2)
library(distributional)
library(dplyr)

test_that("geom_bar_sample tests", {
  # no random variables used - just return normal points
  set.seed(342830498)
  
  p1 <- ggplot(uncertain_mpg, aes(class)) + geom_bar_sample(times=2)
    expect_doppelganger("example1", p1)
  
  p3 <- ggplot(uncertain_mpg, aes(y = class)) +
    geom_bar_sample(aes(fill = drv), alpha=1,
                    position = position_stack_dodge(reverse = TRUE),
                    times=2) +
    theme(legend.position = "top")
  expect_doppelganger("example3", p3)
}
)


