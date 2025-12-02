library(vdiffr)
library(ggplot2)


test_that("nested position_dodge tests", {
  set.seed(8746)
  
  p2 <- ggplot(uncertain_mpg, aes(class)) + 
    geom_bar_sample(aes(fill = drv), position = "dodge_identity", 
                    alpha=0.2, times=2)
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_mpg, aes(class)) + 
    geom_bar_sample(aes(fill = drv), position = "dodge_dodge", times=2)
  expect_doppelganger("Example 3", p3)
  
}
)
