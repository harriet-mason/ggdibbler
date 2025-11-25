library(vdiffr)
library(ggplot2)

suppressMessages({
test_that("geom_dotplot_sample tests", {

  set.seed(783)
  p1 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(alpha=0.2)
  expect_doppelganger("Example 1", p1)
  
  p2 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(binwidth = 1.5, alpha=0.2)
  expect_doppelganger("Example 2", p2)
  
  p3 <- ggplot(uncertain_mtcars, aes(x = mpg)) +
    geom_dotplot_sample(method="histodot", binwidth = 1.5, 
                        alpha=0.2)
  expect_doppelganger("Example 3", p3)
}
)
})




