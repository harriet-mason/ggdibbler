library(vdiffr)
library(ggplot2)
b <- ggplot(smaller_uncertain_diamonds, aes(carat, price))

test_that("geom_hex_sample tests", {
  
  set.seed(890)
  
  p5 <- b + geom_hex_sample(binwidth = c(.1, 500))
  expect_doppelganger("Example 5", p5)
}
)
