library(vdiffr)
library(ggplot2)


test_that("nested position_dodge tests", {
  set.seed(83)
  
  p1 <- ggplot(uncertain_mpg, aes(class)) + 
    geom_bar_sample(aes(fill = drv), position = "identity_dodge", alpha=0.7)
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_mpg, aes(class)) + 
    geom_bar_sample(aes(fill = drv), position = "identity_identity", alpha=0.1)
  expect_doppelganger("Example 2", p2)
  
}
)

ggplot(mpg, aes(class, hwy)) +
  geom_boxplot(colour = "grey50") +
  geom_point(position = "jitter")

ggplot(mpg, aes(class, hwy)) +
  geom_boxplot(colour = "grey50") +
  geom_point_sample(position="jitter")

ggplot(mpg, aes(class, hwy)) +
  geom_boxplot(colour = "grey50") +
  geom_point(position = "identity_jitter")