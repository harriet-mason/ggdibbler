library(ggplot2)
library(distributional)
b  <- ggplot(uncertain_mtcars, aes(cyl, mpg)) + geom_point_sample(seed=4)

test_that("stat_summary_sample tests", {
  
  set.seed(876)
  
  p1 <- b + stat_summary_sample(fun = "median", colour = "red", 
                                geom = "point", seed=4)
  expect_doppelganger("Example 1", p1)
  
  p2 <- b + aes(colour = dist_transformed(vs, factor, as.numeric)) +
    stat_summary_sample(fun = mean, geom="line", seed=4) +
    labs(colour = "factor(vs)")
  expect_doppelganger("Example 2", p2)
}
)



