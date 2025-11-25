library(vdiffr)
library(ggplot2)
library(distributional)
library(dplyr)

test_that("geom_bar_sample tests", {
  # no random variables used - just return normal points
  set.seed(342830498)
  
  p1 <- ggplot(uncertain_mpg, aes(class)) + geom_bar_sample()
    expect_doppelganger("example1", p1)
    
  p2 <- ggplot(uncertain_df, aes(x=trt, y=outcome)) + 
    geom_col_sample()
  expect_doppelganger("example2", p2)
  
  p3 <- ggplot(uncertain_mpg, aes(y = class)) +
    geom_bar_sample(aes(fill = drv), alpha=1,
                    position = position_stack_dodge(reverse = TRUE)) +
    theme(legend.position = "top")
  expect_doppelganger("example3", p3)
}
)


