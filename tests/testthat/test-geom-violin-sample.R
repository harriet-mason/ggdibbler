# libraries
library(vdiffr)
library(ggplot2)
library(dplyr)
library(distributional)

# plot set up
q <- ggplot(uncertain_mtcars,
            aes(dist_transformed(cyl, factor, as.numeric), mpg))

# tests
test_that("geom_violin_sample tests", {
  
  set.seed(545)
  
  p1 <- q + geom_violin_sample()
  expect_doppelganger("Example 1", p1)
  
}
)









