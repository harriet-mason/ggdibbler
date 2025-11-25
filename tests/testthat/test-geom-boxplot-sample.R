library(vdiffr)
library(ggplot2)

# single random variable data prep
uncertain_mpg_new <- uncertain_mpg
uncertain_mpg_new$class <- mpg$class
q <- ggplot(uncertain_mpg, aes(class, hwy))

suppressMessages({
test_that("geom_boxplot_sample tests", {

  set.seed(324)
  
  p1 <- q + geom_boxplot_sample(alpha=0.1)
  expect_doppelganger("Example 1", p1)
  
  p3 <- q + geom_boxplot_sample(aes(colour = drv), 
                                alpha=0.05, position = "dodge_identity")
  expect_doppelganger("Example 3", p3)
  
  p5 <- q + geom_boxplot_sample(alpha=0.1, varwidth = TRUE)
  expect_doppelganger("Example 5", p5)

}
)
})
