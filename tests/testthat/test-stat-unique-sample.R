library(vdiffr)
library(ggplot2)
uncertain_mtcars2 <- uncertain_mtcars |>
  mutate(vs = dist_transformed(vs, as.numeric, as.logical),
         am = dist_transformed(am, as.numeric, as.logical))

test_that("stat_unique_sample tests", {
  
  set.seed(234)
  p1 <- ggplot(uncertain_mtcars2, aes(vs, am)) +
    geom_point_sample(alpha = 0.1, , size=5, stat = "unique_sample")
  expect_doppelganger("Example 1", p1)
  
}
)
